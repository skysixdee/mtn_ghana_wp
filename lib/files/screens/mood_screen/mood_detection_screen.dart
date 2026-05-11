import 'dart:async';
import 'dart:js' as js;
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    return Obx(() => gradientButton(
          title: "Start Detection",
          isLoading: _isDetecting.value,
          onPressed: startDetection,
        ));
  }

  Widget uploadButton() {
    return Obx(() => gradientButton(
          title: "Upload Picture",
          isLoading: appCont.isUploading.value,
          onPressed: () =>
              html.document.getElementById("upload-input")?.click(),
        ));
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
                  title: "Face Recognition",
                  subTitle: "Detect your face expressions",
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
      title: "Face Recognition",
      fontName: FontName.bold,
      fontSize: 16,
      color: appCont.isDarkTheme.value ? white : black,
    );
  }
}


// // import 'package:flutter/material.dart';
// // import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
// import 'dart:js' as js;
// // class MoodDetectionScreen extends StatefulWidget {
// //   const MoodDetectionScreen({super.key});

// //   @override
// //   State<MoodDetectionScreen> createState() => _MoodDetectionScreenState();
// // }

// // class _MoodDetectionScreenState extends State<MoodDetectionScreen>
// //     with SingleTickerProviderStateMixin {
// //   late AnimationController _controller;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _controller = AnimationController(vsync: this);
// //   }

// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Center(
// //       child: CustomText(title: "Mood Detection"),
// //     );
// //   }
// // }

// import 'dart:async';
// import 'dart:ui' as html;
// import 'dart:js' as js;
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:mtn_ghana_wp/files/enums/fonts.dart';
// import 'package:mtn_ghana_wp/files/player_view/new_player_controller.dart';
// import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/gradient_button.dart';
// import 'package:mtn_ghana_wp/files/reusable_widgets/custom_screen_header_view.dart';
// import 'package:mtn_ghana_wp/files/reusable_widgets/custom_scroll_view/generic_scroll_view.dart';
// import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
// import 'package:mtn_ghana_wp/files/screens/mood_screen/expression_result_screen.dart';
// import 'package:mtn_ghana_wp/files/utility/colors.dart';
// import 'package:mtn_ghana_wp/files/utility/images.dart';
// import 'package:mtn_ghana_wp/main.dart';
// import 'package:responsive_builder/responsive_builder.dart';
// import 'package:web/web.dart' as html;
// import 'dart:html' as html;

// import 'dart:async';
// import 'dart:js' as js;
// import 'dart:html' as html;

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:skeletonizer/skeletonizer.dart';

// import 'dart:async';
// import 'dart:convert';
// import 'dart:html' as html;

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:skeletonizer/skeletonizer.dart';

// import 'dart:async';
// import 'dart:js' as js;

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:responsive_builder/responsive_builder.dart';
// import 'package:skeletonizer/skeletonizer.dart';

// class FaceRecognitionScreen extends StatefulWidget {
//   const FaceRecognitionScreen({super.key});

//   @override
//   State<FaceRecognitionScreen> createState() => _FaceRecognitionScreenState();
// }

// class _FaceRecognitionScreenState extends State<FaceRecognitionScreen> {
//   final RxString _expression = 'Unknown'.obs;
//   final RxBool _isDetecting = false.obs;
//   RxBool isUploading = false.obs;
//   //TextEditingController textEditingController = TextEditingController();
//   PlayerController pCont = Get.find();
//   StreamSubscription? _captureListener;
//   Timer? _timer;
//   final RxBool _isUploading = false.obs;

//   @override
//   void initState() {
//     super.initState();

//     //   html.window.onMessage.listen((event) {
//     //     final data = event.data;

//     //      if (data is Map && data['type'] == 'uploadStarted') {
//     //   appCont.isUploading.value = true;
//     // }
//     // if (data is Map && data['type'] == 'uploadFinished') {
//     //   appCont.isUploading.value = false;
//     // }

//     //     if (data is Map && data['type'] == 'expressionConfirmed') {
//     //       final base64Image = data['image'] as String?;
//     //       final expression = data['expression'] as String?;
//     //       final source = data['source'] as String?;

//     //       if (base64Image != null && expression != null) {
//     //         Navigator.push(
//     //           context,
//     //           MaterialPageRoute(
//     //             builder: (_) => ExpressionResultScreen(
//     //               base64Image: base64Image,
//     //               expression: expression,
//     //               source: source ?? "live",
//     //               onRecapture: () => startDetection(),
//     //             ),
//     //           ),
//     //         );
//     //       }
//     //     }
//     //   });
//     // }

//     html.window.onMessage.listen((event) {
//       final data = event.data;

//       Map<String, dynamic>? dataMap;
//       try {
//         if (data != null) {
//           dataMap = Map<String, dynamic>.from(
//             js.JsObject.fromBrowserObject(data) as dynamic,
//           );
//         }
//       } catch (_) {
//         dataMap = null;
//       }

//       if (dataMap == null) return;

//       final type = dataMap['type'];

//       if (type == 'uploadStarted') {
//         appCont.isUploading.value = true;
//       }
//       if (type == 'uploadFinished') {
//         appCont.isUploading.value = false;
//       }

//       if (type == 'expressionConfirmed') {
//         final base64Image = dataMap['image'] as String?;
//         final expression = dataMap['expression'] as String?;
//         final source = dataMap['source'] as String?;

//         if (base64Image != null && expression != null) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => ExpressionResultScreen(
//                 base64Image: base64Image,
//                 expression: expression,
//                 source: source ?? "live",
//                 onRecapture: () => startDetection(),
//               ),
//             ),
//           );
//         }
//       }
//     });
//   }

//   void startDetection() {
//     _isDetecting.value = true;
//     js.context.callMethod('detectFace');

//     _timer?.cancel();
//     _timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
//       final expr = js.context['lastExpression'];
//       if (expr != null && expr != _expression.value) {
//         _expression.value = expr;
//       }
//     });

//     _captureListener?.cancel();
//     _captureListener = html.window.on['expressionCaptured'].listen((event) {
//       final detail = (event as html.CustomEvent).detail;
//       print('Expression confirmed: $detail');
//       _isDetecting.value = false;
//       _timer?.cancel();
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     _captureListener?.cancel();
//     super.dispose();
//   }

//   Widget detectButton() {
//     return Obx(() => gradientButton(
//           title: "Start Detection",
//           isLoading: _isDetecting.value,
//           onPressed: startDetection,
//         ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveBuilder(
//       builder: (context, si) {
//         return Column(
//           children: [
//             Expanded(
//               child: GenericScrollView(
//                 onlyGrid: si.isMobile,
//                 sliverToBoxAdapter: CustomScreenHeaderView(
//                   imageName: nameTuneHeaderPng,
//                   title: "Face Recognition",
//                   subTitle: "Detect your face expressions",
//                 ),
//                 collapsedHeight: si.isMobile ? 81 : 61,
//                 sliverAppBar: Column(
//                   children: [
//                     searchFaceRecognitionBuilder(),
//                     Container(height: 1),
//                   ],
//                 ),
//                 itemCount: 1,
//                 builder: (p0) {
//                   return Obx(() => Skeletonizer(
//                         enabled: _isDetecting.value,
//                         child: Center(
//                             child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             detectButton(),
//                             const SizedBox(height: 20),
//                             uploadButton(),
//                           ],
//                         )),
//                       ));
//                 },
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget searchFaceRecognitionBuilder() {
//     return ResponsiveBuilder(
//       builder: (context, si) {
//         return Obx(() {
//           return Container(
//             color: appCont.isDarkTheme.value ? blackD : lightGrey,
//             height: si.isMobile ? 80 : 60,
//             child: Padding(
//               padding: EdgeInsets.only(
//                   bottom: 1,
//                   left: si.isMobile ? 8 : 25,
//                   right: si.isMobile ? 8 : 25),
//               child: si.isMobile
//                   ? Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         title(),
//                         const SizedBox(height: 2),
//                         //    title1(),
//                       ],
//                     )
//                   : Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         title(),
//                         //    Flexible(child: textField(si)),
//                       ],
//                     ),
//             ),
//           );
//         });
//       },
//     );
//   }

//   Widget title() {
//     return CustomText(
//       title: "Face Recognition",
//       fontName: FontName.bold,
//       fontSize: 16,
//       color: appCont.isDarkTheme.value ? white : blueNepalColor,
//     );
//   }

//   Widget title1() {
//     return CustomText(
//       title: "Face Recognition",
//       fontName: FontName.bold,
//       fontSize: 16,
//       color: appCont.isDarkTheme.value ? blackD : lightGrey,
//     );
//   }

//   Widget uploadButton() {
//     return Obx(() => gradientButton(
//           title: "Upload Picture",
//           isLoading: appCont.isUploading.value,
//           onPressed: () =>
//               html.document.getElementById("upload-input")?.click(),
//         ));
//   }
// }

// //   Widget uploadButton() {
// //   return Obx(() {
// //     return ElevatedButton(
// //       onPressed: appCont.isUploading.value
// //           ? null 
// //           : () {
// //               html.document.getElementById("upload-input")?.click();
// //             },
// //       child: appCont.isUploading.value
// //           ? loadingIndicator(height: 20, width: 20, radius: 10)
// //           : const Text("Upload Picture"),
// //     );
// //   });
// // }
