import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/loading_indicator.dart';
import 'package:mtn_ghana_wp/files/screens/mood_detect/mood_service.dart';
import 'package:mtn_ghana_wp/files/screens/mood_detect/moods_controller.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:mtn_ghana_wp/main.dart';

import 'package:responsive_builder/responsive_builder.dart';
//import 'package:mood_detect/mood_detect/mood_service.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  bool _isCameraReady = false;
  bool _isDetecting = false;
  //String _mood = '';

  MoodsController moodsController = Get.find();

  final Map<String, String> _moodEmoji = {
    'happy': '😊',
    'sad': '😢',
    'angry': '😠',
    'surprised': '😮',
    'fearful': '😨',
    'disgusted': '🤢',
    'neutral': '😐',
  };

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;

    _controller = CameraController(
      cameras.first,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await _controller!.initialize();

    if (mounted) {
      setState(() => _isCameraReady = true);
    }
  }

  Future<void> _detectMood() async {
    if (_controller == null || !_isCameraReady || _isDetecting) return;
    setState(() {
      _isDetecting = true;
    });
    try {
      final XFile file = await _controller!.takePicture();
      final Uint8List bytes = await file.readAsBytes();
      moodsController.imageBytes.value = bytes;
      final result = await MoodService.detectMood(bytes);
      moodsController.mood.value = result['mood'] ?? 'unknown';
    } catch (e) {
      setState(() => moodsController.mood.value = 'error: $e');
    } finally {
      setState(() => _isDetecting = false);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              color: appCont.isDarkTheme.value ? blackD : white,
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              popupHeaderView(),
              cameraPreview1(),
              const SizedBox(height: 8),
              if (moodsController.mood.value.isNotEmpty) youAreLookingTitle(),
              const SizedBox(height: 8),
              bottomButtons(si),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Expanded cameraPreview1() {
    return Expanded(
      flex: 3,
      child: _isCameraReady
          ? ClipRRect(
              child: CameraPreview(_controller!),
            )
          : Center(
              child: CircularProgressIndicator(
                  color: appCont.isDarkTheme.value ? white : black),
            ),
    );
  }

  Container popupHeaderView() {
    return Container(
      color: appCont.isDarkTheme.value ? blackD : white,
      child: closeButton(),
    );
  }

  Container youAreLookingTitle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(8),
      child: CustomText(
        title: youAreLookingTodatyStr.replaceAll("MOOD",
            "${_moodEmoji[moodsController.mood.value] ?? '🙂'} ${moodsController.mood.value.toUpperCase()}"),
      ),
    );
  }

  Padding bottomButtons(SizingInformation si) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Obx(
        () {
          return moodsController.mood.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    detectButton(si),
                    if (moodsController.mood.isNotEmpty) searchButton(si)
                  ],
                )
              : detectButton(si);
        },
      ),
    );
  }

  GenericButton searchButton(SizingInformation si) {
    return GenericButton(
      onTap: () {
        print("object");
        Get.back();
        moodsController.getMoodToneList(moodsController.mood.value);
      },
      fontName:
          FontName.semiBold, //si.isMobile ? FontName.bold : FontName.bold,
      fontSize: si.isMobile ? 13 : 14,
      textColorD: blackD,
      title: "$searchStr ${moodsController.mood.value} $moodsStr",
    );
  }

  GenericButton detectButton(SizingInformation si) {
    return GenericButton(
      textColorD: blackD,
      fontName: FontName
          .semiBold, //fontName: si.isMobile ? FontName.medium : FontName.bold,
      fontSize: si.isMobile ? 13 : 14,
      onTap: _isDetecting ? null : _detectMood,
      leadingIcon: _isDetecting ? loadingIndicator() : null,
      title: detectMyMoodStr,
    );
  }

  Row closeButton() {
    return Row(
      children: [
        GenericButton(
          bgColor: transparent,
          leadingIcon: Icon(
            Icons.close,
            color: appCont.isDarkTheme.value ? whiteD : black,
          ),
          onTap: () {
            Get.back();
            moodsController.mood.value = '';
          },
        )
      ],
    );
  }
}
