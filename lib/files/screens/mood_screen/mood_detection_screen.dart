import 'dart:async';
import 'dart:js' as js;
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/player_view/new_player_controller.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/gradient_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_screen_header_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_scroll_view/generic_scroll_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/screens/mood_screen/expression_result_screen.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/images.dart';
import 'package:mtn_ghana_wp/main.dart';

class FaceRecognitionScreen extends StatefulWidget {
  const FaceRecognitionScreen({super.key});

  @override
  State<FaceRecognitionScreen> createState() => _FaceRecognitionScreenState();
}

class _FaceRecognitionScreenState extends State<FaceRecognitionScreen> {
  final RxString _expression = 'Unknown'.obs;
  final RxBool _isDetecting = false.obs;
  RxBool isUploading = false.obs;
  PlayerController pCont = Get.find();
  StreamSubscription? _captureListener;
  StreamSubscription? _messageListener; // 👈 added
  Timer? _timer;
  final RxBool _isUploading = false.obs;

  @override
  void initState() {
    super.initState();
    _resetState();

    _messageListener = html.window.onMessage.listen((event) {
      final data = event.data;
      if (data == null) return;

      final type = data['type']?.toString();

      if (type == 'uploadStarted') {
        appCont.isUploading.value = true;
      } else if (type == 'uploadFinished') {
        appCont.isUploading.value = false;
      } else if (type == 'expressionConfirmed') {
        final base64Image = data['image']?.toString();
        final expression = data['expression']?.toString();
        final source = data['source']?.toString();

        if (base64Image != null && expression != null && mounted) {
          // 👈 mounted check
          _isDetecting.value = false;
          _timer?.cancel();

          if (!mounted) return; //

          //   if (base64Image != null && expression != null) {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (_) => ExpressionResultScreen(
          //       base64Image: base64Image,
          //       expression: expression,
          //       source: source ?? "live",
          //       onRecapture: () => startDetection(),
          //     ),
          //   ),
          // );
          // In FaceRecognitionScreen, where you build ExpressionResultScreen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ExpressionResultScreen(
                base64Image: base64Image,
                expression: expression,
                source: source ?? "live",
                onRecapture: () {
                  Navigator.pop(context); // 👈 pop result screen first
                  startDetection();
                },
                onCancel: () {
                  Navigator.pop(context); // 👈 just pop back cleanly
                },
              ),
            ),
          );
        }
      }
    });
  }

  void _resetState() {
    _expression.value = 'Unknown';
    _isDetecting.value = false;
    appCont.isUploading.value = false;
    _timer?.cancel();
    _captureListener?.cancel();
  }

  void startDetection() {
    _isDetecting.value = true;
    js.context.callMethod('detectFace');

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      final expr = js.context['lastExpression']?.toString(); // 👈 null-safe
      if (expr != null && expr != _expression.value) {
        _expression.value = expr;
      }
    });

    _captureListener?.cancel();

    _captureListener =
        const html.EventStreamProvider<html.CustomEvent>('expressionCaptured')
            .forTarget(html.window)
            .listen((event) {
      final detail = event.detail;
      print('Expression confirmed: $detail');
      _isDetecting.value = false;
      _timer?.cancel();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _captureListener?.cancel();
    _messageListener?.cancel();
    super.dispose();
  }

  Widget detectButton() {
    return Obx(() => GenericButton(
          title: _isDetecting.value ? "Detecting..." : startDetectionStr,
          //isLoading: _isDetecting.value,
          onTap: _isDetecting.value ? null : startDetection,
        ));
    // return Obx(() =>
    // gradientButton(
    //       title: startDetectionStr,
    //       isLoading: _isDetecting.value,
    //       onPressed: startDetection,
    //     ));
  }

  Widget uploadButton() {
    return Obx(() => GenericButton(
          title: appCont.isUploading.value ? "Uploading..." : uploadPictureStr,
          //isLoading: appCont.isUploading.value,
          onTap: appCont.isUploading.value
              ? null
              : () => html.document.getElementById("upload-input")?.click(),
        ));
    // gradientButton(
    //       title: uploadPictureStr,
    //       isLoading: appCont.isUploading.value,
    //       onPressed: () =>
    //           html.document.getElementById("upload-input")?.click(),
    //     ));
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Column(
          children: [
            Expanded(
              child: GenericScrollView(
                onlyGrid: si.isMobile,
                sliverToBoxAdapter: CustomScreenHeaderView(
                  imageName: nameTuneHeaderPng,
                  title: faceRecognitionStr,
                  subTitle: detectFaceExpressionsStr,
                ),
                collapsedHeight: si.isMobile ? 81 : 61,
                sliverAppBar: Column(
                  children: [
                    searchFaceRecognitionBuilder(),
                    Container(height: 1),
                  ],
                ),
                itemCount: 1,
                builder: (p0) {
                  return Obx(() => Skeletonizer(
                        enabled: _isDetecting.value,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              detectButton(),
                              const SizedBox(height: 20),
                              uploadButton(),
                            ],
                          ),
                        ),
                      ));
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget searchFaceRecognitionBuilder() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Obx(() {
          return Container(
            color: appCont.isDarkTheme.value ? blackD : lightGrey,
            height: si.isMobile ? 80 : 60,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 1,
                left: si.isMobile ? 8 : 25,
                right: si.isMobile ? 8 : 25,
              ),
              child: si.isMobile
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title(),
                        const SizedBox(height: 2),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [title()],
                    ),
            ),
          );
        });
      },
    );
  }

  Widget title() {
    return CustomText(
      title: faceRecognitionStr,
      fontName: FontName.bold,
      fontSize: 16,
      color: appCont.isDarkTheme.value ? white : black,
    );
  }
}
