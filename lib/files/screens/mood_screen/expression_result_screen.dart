import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:glossy/glossy.dart';

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
//import 'package:mtn_sa_wp/files/reusable_widgets/player_view/max_right_view.dart';

import 'package:glossy/glossy.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/gradient_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/get_navigation_view.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/screens/mood_screen/max_right1.dart';
import 'package:mtn_ghana_wp/files/screens/mood_screen/mood_detection_screen.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/main.dart';

import 'package:responsive_builder/responsive_builder.dart';
import 'dart:html' as html;

class ExpressionResultScreen extends StatelessWidget {
  final String base64Image;
  final String expression;
  final String source;
  final VoidCallback onRecapture;
  final VoidCallback onCancel;

  const ExpressionResultScreen({
    super.key,
    required this.base64Image,
    required this.source,
    required this.expression,
    required this.onRecapture,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final decodedBytes = base64Decode(base64Image.split(',').last);

    return ResponsiveBuilder(
      builder: (context, sizingInfo) {
        return Scaffold(
          body: sizingInfo.isMobile
              ? _mobileView(context, decodedBytes)
              : _desktopView(context, decodedBytes),
        );
      },
    );
  }

  // Widget _desktopView(BuildContext context, Uint8List decodedBytes) {
  //   return Obx(() => Container(
  //         width: double.infinity,
  //         color: appCont.isDarkTheme.value ? blackD : white,
  //         child: GlossyContainer(
  //           strengthX: 6.0,
  //           strengthY: 6.0,
  //           height: double.infinity,
  //           width: double.infinity,
  //           child: LayoutBuilder(
  //             builder: (context, constraints) {
  //               return Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   MediaQuery.of(context).size.width < 1100
  //                       ? Flexible(
  //                           child: SingleChildScrollView(
  //                             scrollDirection: Axis.horizontal,
  //                             child: _fixedWidthContent(context,
  //                                 width: 1090, decodedBytes: decodedBytes),
  //                           ),
  //                         )
  //                       : Flexible(
  //                           child: _fixedWidthContent(context,
  //                               decodedBytes: decodedBytes),
  //                         ),
  //                 ],
  //               );
  //             },
  //           ),
  //         ),
  //       ));
  // }
  Widget _desktopView(BuildContext context, Uint8List decodedBytes) {
    return Obx(() => Container(
          width: double.infinity,
          color: appCont.isDarkTheme.value ? blackD : white,
          child: Column(
            children: [
              getNavigationView(
                  "Expression Result: $expression"), // 👈 full width here
              Expanded(
                child: GlossyContainer(
                  strengthX: 6.0,
                  strengthY: 6.0,
                  height: double.infinity,
                  width: double.infinity,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MediaQuery.of(context).size.width < 1100
                              ? Flexible(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: _fixedWidthContent(context,
                                        width: 1090,
                                        decodedBytes: decodedBytes),
                                  ),
                                )
                              : Flexible(
                                  child: _fixedWidthContent(context,
                                      decodedBytes: decodedBytes),
                                ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _mobileView(BuildContext context, Uint8List decodedBytes) {
    return Obx(() => Container(
          width: double.infinity,
          color: appCont.isDarkTheme.value ? Colors.black : white,
          child: GlossyContainer(
            strengthX: 4.0,
            strengthY: 4.0,
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ✅ Breadcrumb
                  getNavigationView("Expression Result"),
                  const SizedBox(height: 12),
                  // ✅ Detected Expression
                  // Obx(() => Text(
                  //       'Detected Expression: $expression',
                  //       style: TextStyle(
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.bold,
                  //         color: appCont.isDarkTheme.value ? white : blueNepalColor,
                  //       ),
                  //       textAlign: TextAlign.center,
                  //     )),
                  const SizedBox(height: 20),
                  Image.memory(
                    decodedBytes,
                    height: 220,
                    width: 220,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                  actionButton(context),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 500,
                    child: MaxRightView2(expression: expression),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  SizedBox _fixedWidthContent(
    BuildContext context, {
    double? width,
    required Uint8List decodedBytes,
  }) {
    return SizedBox(
      width: width ?? 1200,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  getNavigationView("Expression Result: $expression"),
            const SizedBox(height: 12),

            // Obx(() => Text(
            //       'Detected Expression: $expression',
            //       style: TextStyle(
            //         fontSize: 20,
            //         fontWeight: FontWeight.bold,
            //         color: appCont.isDarkTheme.value ? white : blueNepalColor,
            //       ),
            //     )),
            const SizedBox(height: 20),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Image.memory(
                            decodedBytes,
                            height: 250,
                            width: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 20),
                        actionButton(context),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    child: SizedBox(
                      width: 350,
                      child: MaxRightView2(expression: expression),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget actionButton(BuildContext context) {
  //   if (source == "live") {
  //     return recaptureButton();
  //   } else if (source == "upload") {
  //     return reuploadButton(context);
  //   } else {
  //     return const SizedBox.shrink();
  //   }
  // }

  Widget actionButton(BuildContext context) {
    Widget? primaryBtn;

    if (source == "live") {
      primaryBtn = recaptureButton();
    } else if (source == "upload") {
      primaryBtn = reuploadButton(context);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (primaryBtn != null) primaryBtn,
        if (primaryBtn != null) const SizedBox(height: 12),
        cancelButton(context),
      ],
    );
  }

  Widget cancelButton(BuildContext context) {
    return gradientButton(
      title: "Cancel",
      isLoading: false,
      onPressed: onCancel,
    );
  }

  Widget recaptureButton() {
    return gradientButton(
      title: "Recapture",
      isLoading: false,
      onPressed: onRecapture,
    );
  }

  Widget reuploadButton(BuildContext context) {
    return gradientButton(
      title: "Re-upload",
      isLoading: false,
      onPressed: () {
        html.document.getElementById("upload-input")?.click();
      },
    );
  }
}
// class ExpressionResultScreen extends StatelessWidget {
//   final String base64Image;
//   final String expression;
//   final String source; 
//   final VoidCallback onRecapture;

//   const ExpressionResultScreen({
//     super.key,
//     required this.base64Image,
//    required this.source,
//     required this.expression,
//     required this.onRecapture,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final decodedBytes = base64Decode(base64Image.split(',').last);
  
//     return ResponsiveBuilder(
//       builder: (context, sizingInfo) {
//         return Scaffold(
//           body: sizingInfo.isMobile
//               ? _mobileView(context, decodedBytes) 
//               : _desktopView(context, decodedBytes), 
//         );
//       },
//     );
//   }

// Widget _desktopView(BuildContext context, Uint8List decodedBytes) {
//   return Obx(() => Container(
//     width: double.infinity,
//     color: appCont.isDarkTheme.value ? blackD : white,
//     child: GlossyContainer(
//       strengthX: 6.0,
//       strengthY: 6.0,
//       height: double.infinity,
//       width: double.infinity,
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           return Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               MediaQuery.of(context).size.width < 1100
//                   ? Flexible(
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: _fixedWidthContent(context,
//                           width: 1090,
//                           decodedBytes: decodedBytes,
//                         ),
//                       ),
//                     )
//                   : Flexible(
//                       child: _fixedWidthContent(context, decodedBytes: decodedBytes),
//                     ),
//             ],
//           );
//         },
//       ),
//     ),
//   ));
// }

// Widget _mobileView(BuildContext context, Uint8List decodedBytes) {
//   return Obx(() => Container(
//     width: double.infinity,
//     color: appCont.isDarkTheme.value ? Colors.black : white,
//     child: GlossyContainer(
//       strengthX: 4.0,
//       strengthY: 4.0,
//       height: double.infinity,
//       width: double.infinity,
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 IconButton(
//                   icon: Icon(
//                     Icons.arrow_back,
//                     color: appCont.isDarkTheme.value ? white : blueNepalColor,
//                   ),
//                   tooltip: 'Back to Face Recognition',
//                   onPressed: () => Navigator.pop(context),
//                 ),
//                 Expanded(
//                   child: Text(
//                     'Detected Expression: $expression',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: appCont.isDarkTheme.value ? white : blueNepalColor,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 const SizedBox(width: 48),
//               ],
//             ),
//             const SizedBox(height: 20),
//             Image.memory(
//               decodedBytes,
//               height: 220,
//               width: 220,
//               fit: BoxFit.cover,
//             ),
//             const SizedBox(height: 20),
//             actionButton(context),
//             const SizedBox(height: 30),
//             SizedBox(
//               width: double.infinity,
//               height: 400,
//               child: MaxRightView2(expression: expression),
//             ),
//           ],
//         ),
//       ),
//     ),
//   ));
// }

// SizedBox _fixedWidthContent(BuildContext context, {
//   double? width,
//   required Uint8List decodedBytes,
// }) {
//   return SizedBox(
//     width: width ?? 1200,
//     child: Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: Column(
//         children: [
//           Expanded(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           IconButton(
//                             icon: Icon(
//                               Icons.arrow_back,
//                               color: appCont.isDarkTheme.value ? white : blueNepalColor,
//                             ),
//                             tooltip: 'Back to Face Recognition',
//                             onPressed: () => Navigator.pop(context),
//                           ),
//                           const SizedBox(width: 8),
//                           Text(
//                             'Detected Expression: $expression',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: appCont.isDarkTheme.value ? white : blueNepalColor,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       Flexible(
//                         child: Image.memory(
//                           decodedBytes,
//                           height: 250,
//                           width: 250,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       actionButton(context),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(width: 20),
//                 Flexible(
//                   child: SizedBox(
//                     width: 300,
//                     child: MaxRightView2(expression: expression),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
//   Widget actionButton(BuildContext context) {
//   if (source == "live") {
//     return recaptureButton();
//   } else if (source == "upload") {
//     return reuploadButton(context);
//   } else {
//     return const SizedBox.shrink();
//   }
// }



//   Widget recaptureButton() {
//   return gradientButton(
//     title: "Recapture",
//     isLoading: false,
//     onPressed: onRecapture,
//   );
// }

 
 
//  Widget reuploadButton(BuildContext context) {
//   return gradientButton(
//     title: "Re-upload",
//     isLoading: false,
//     onPressed: () {
//       html.document.getElementById("upload-input")?.click();
//     },
//   );
// }
// }

// 

//   Widget actionButton() {
//   if (source == "live") {
//     return GenericButton(
//       width: 150,
//       height: 35,
//       title: "Recapture",
//       leadingIcon: const Icon(Icons.camera_alt, size: 14, color: black),
//       bgColor: appCont.isDarkTheme.value ? yellowD : yellow,
//       onTap: onRecapture,
//     );
//   } else {
//     return GenericButton(
//       width: 150,
//       height: 35,
//       title: "Upload Again",
//       leadingIcon: const Icon(Icons.upload, size: 14, color: black),
//       bgColor: appCont.isDarkTheme.value ? yellowD : yellow,
//       onTap: () {
//         // Trigger upload in HTML
//         html.document.getElementById("upload-btn")?.click();
//      //   Navigator.pop(context); // close current screen, wait for new event
//       },
//     );
//   }
// }





// import 'dart:convert';
// import 'package:flutter/material.dart';

// class ExpressionResultScreen extends StatelessWidget {
//   final String base64Image;
//   final String expression;

//   ExpressionResultScreen({
//     super.key,
//     required this.base64Image,
//     required this.expression,
//   });

//   // ✅ Same as your JS emotionTuneMap
//   final Map<String, Map<String, String>> emotionTuneMap = {
//     'happy': {
//       'cover': 'https://upload.wikimedia.org/wikipedia/en/9/9f/Pharrell_Williams_-_Happy.png',
//       'name': 'Happy',
//       'artist': 'Pharrell Williams'
//     },
//     'sad': {
//       'cover': 'https://upload.wikimedia.org/wikipedia/en/2/24/Adele_-_Someone_Like_You.png',
//       'name': 'Someone Like You',
//       'artist': 'Adele'
//     },
//     'angry': {
//       'cover': 'https://upload.wikimedia.org/wikipedia/en/4/4b/Linkin_Park_-_Numb.jpg',
//       'name': 'Numb',
//       'artist': 'Linkin Park'
//     },
//     'surprised': {
//       'cover': 'https://upload.wikimedia.org/wikipedia/en/3/37/Michael_Jackson_-_Thriller.png',
//       'name': 'Thriller',
//       'artist': 'Michael Jackson'
//     },
//     'neutral': {
//       'cover': 'https://upload.wikimedia.org/wikipedia/en/4/49/Coldplay_-_Yellow.jpg',
//       'name': 'Yellow',
//       'artist': 'Coldplay'
//     },
//     'fearful': {
//       'cover': 'https://upload.wikimedia.org/wikipedia/en/f/f9/Lady_Gaga_-_Poker_Face.png',
//       'name': 'Poker Face',
//       'artist': 'Lady Gaga'
//     },
//     'disgusted': {
//       'cover': 'https://upload.wikimedia.org/wikipedia/en/8/82/Radiohead_-_Creep.jpg',
//       'name': 'Creep',
//       'artist': 'Radiohead'
//     }
//   };

//   @override
//   Widget build(BuildContext context) {
//     final decodedBytes = base64Decode(base64Image.split(',').last);

//     // ✅ Get the tune details for this expression
//     final tune = emotionTuneMap[expression.toLowerCase()] ?? {
//       'cover': '',
//       'name': 'No tune found',
//       'artist': ''
//     };

//     return Scaffold(
//       appBar: AppBar(title: const Text("Expression Result")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Left: Snapshot + tune-info side by side
//             Expanded(
//               flex: 1,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Detected Expression: $expression',
//                     style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Snapshot
//                       Image.memory(
//                         decodedBytes,
//                         height: 200,
//                         width: 200,
//                         fit: BoxFit.cover,
//                       ),
//                       const SizedBox(width: 60),
//                       // Tune info
//                       if (tune['cover']!.isNotEmpty)
//                        Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Image.network(
//                             //   tune['cover']!,
//                             //   height: 80,
//                             //   width: 80,
//                             //   fit: BoxFit.cover,
//                             // ),
//                             const SizedBox(height: 10),
//                             Text(
//                               tune['name']!,
//                               style: const TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               tune['artist']!,
//                               style: const TextStyle(
//                                   fontSize: 16, color: Colors.grey),
//                             ),
//                           ],
//                         )
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(width: 16),

//             // Right: MaxRightView
//             Expanded(
//               flex: 1,
//               child: MaxRightView(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


//hardcoded

// import 'dart:convert';
// import 'package:flutter/material.dart';

// class ExpressionResultScreen extends StatelessWidget {
//   final String base64Image;
//   final String expression;

//   ExpressionResultScreen({
//     super.key,
//     required this.base64Image,
//     required this.expression,
//   });

//   final Map<String, Map<String, String>> emotionTuneMap = {
//     'Happy': {
//       'cover': 'https://upload.wikimedia.org/wikipedia/en/9/9f/Pharrell_Williams_-_Happy.png',
//       'name': 'Happy',
//       'artist': 'Pharrell Williams'
//     },
//     'Sad': {
//       'cover': 'https://upload.wikimedia.org/wikipedia/en/2/24/Adele_-_Someone_Like_You.png',
//       'name': 'Someone Like You',
//       'artist': 'Adele'
//     },
//     'Angry': {
//       'cover': 'https://upload.wikimedia.org/wikipedia/en/4/4b/Linkin_Park_-_Numb.jpg',
//       'name': 'Numb',
//       'artist': 'Linkin Park'
//     },
//     'Surprised': {
//       'cover': 'https://upload.wikimedia.org/wikipedia/en/3/37/Michael_Jackson_-_Thriller.png',
//       'name': 'Thriller',
//       'artist': 'Michael Jackson'
//     },
//     'Neutral': {
//       'cover': 'https://upload.wikimedia.org/wikipedia/en/4/49/Coldplay_-_Yellow.jpg',
//       'name': 'Yellow',
//       'artist': 'Coldplay'
//     },
//     'Fearful': {
//       'cover': 'https://upload.wikimedia.org/wikipedia/en/f/f9/Lady_Gaga_-_Poker_Face.png',
//       'name': 'Poker Face',
//       'artist': 'Lady Gaga'
//     },
//     'Disgusted': {
//       'cover': 'https://upload.wikimedia.org/wikipedia/en/8/82/Radiohead_-_Creep.jpg',
//       'name': 'Creep',
//       'artist': 'Radiohead'
//     }
//   };

//   // Hardcoded up next list similar to the JS example
//   final List<Map<String, String>> upNextList = [
//     {
//       'cover': 'https://upload.wikimedia.org/wikipedia/en/d/d2/Lucky_Dube_-_Slave.jpg',
//       'title': 'Guns And Roses',
//       'artist': 'Lucky Dube'
//     },
//     {
//       'cover': 'https://upload.wikimedia.org/wikipedia/en/b/b4/Lucky_Dube_-_Remember_Me.jpg',
//       'title': 'Remember Me',
//       'artist': 'Lucky Dube'
//     },
//     {
//       'cover': 'https://upload.wikimedia.org/wikipedia/en/e/ea/Lucky_Dube_-_The_Way_It_Is.jpg',
//       'title': 'The Way It Is',
//       'artist': 'Lucky Dube'
//     },
//     {
//       'cover': 'https://upload.wikimedia.org/wikipedia/en/d/d2/Lucky_Dube_-_Slave.jpg',
//       'title': 'Guns',
//       'artist': 'Lucky Dube'
//     },
//     {
//       'cover': 'https://upload.wikimedia.org/wikipedia/en/b/b4/Lucky_Dube_-_Remember_Me.jpg',
//       'title': 'Happy Me',
//       'artist': 'Lucky Dube'
//     },
//     {
//       'cover': 'https://upload.wikimedia.org/wikipedia/en/e/ea/Lucky_Dube_-_The_Way_It_Is.jpg',
//       'title': 'Party',
//       'artist': 'Lucky Dube'
//     },
//     {
//       'cover': 'https://upload.wikimedia.org/wikipedia/en/e/ea/Lucky_Dube_-_The_Way_It_Is.jpg',
//       'title': 'Party',
//       'artist': 'Lucky Dube'
//     },
//     {
//       'cover': 'https://upload.wikimedia.org/wikipedia/en/e/ea/Lucky_Dube_-_The_Way_It_Is.jpg',
//       'title': 'Party',
//       'artist': 'Lucky Dube'
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final decodedBytes = base64Decode(base64Image.split(',').last);

//     final tune = emotionTuneMap[expression.toLowerCase()] ?? {
//       'cover': '',
//       'name': 'No tune found',
//       'artist': ''
//     };

//     return Scaffold(
//       appBar: AppBar(title: const Text("Expression Result")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Left: Snapshot + tune-info side by side
//             Expanded(
//            //   flex: 1,
//               child: Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Detected Expression: $expression',
//                       style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 20),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Snapshot
//                         Image.memory(
//                           decodedBytes,
//                           height: 200,
//                           width: 200,
//                           fit: BoxFit.cover,
//                         ),
                    //    const SizedBox(width: 60),
                        // Tune info
                      //tune artist section              //  if (tune['cover']!.isNotEmpty)
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     // Image.network(
                          //     //   tune['cover']!,
                          //     //   height: 80,
                          //     //   width: 80,
                          //     //   fit: BoxFit.cover,
                          //     // ),
                          // //    const SizedBox(height: 10),
                          //     // Text(
                          //     //   tune['name']!,
                          //     //   style: const TextStyle(
                          //     //       fontSize: 18, fontWeight: FontWeight.bold),
                          //     // ),
                          //     // Text(
                          //     //   tune['artist']!,
                          //     //   style: const TextStyle(
                          //     //       fontSize: 16, color: Colors.grey),
                          //     // ),
                          //   ],
                          // )
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

           // const SizedBox(width: 16),

            // Right: Up Next section (hardcoded)


            // Padding(
            //   padding: const EdgeInsets.only(right: 150,left: 60),
            //   child: Container(
            //     width: 400,
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(8),
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.black.withOpacity(0.1),
            //           blurRadius: 6,
            //           offset: const Offset(0, 4),
            //         )
            //       ],
            //     ),
            //     padding: const EdgeInsets.all(20),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text( 'Detected Expression: $expression',
            //          // 'Up Next',
            //           style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 20,
            //             color: Colors.amber[700],
            //             decoration: TextDecoration.underline,
            //             decorationThickness: 2,
            //           ),
            //         ),
            //         const SizedBox(height: 10),
            //         Expanded(
            //           child: ListView.builder(
            //             itemCount: upNextList.length,
            //             itemBuilder: (context, index) {
            //               final item = upNextList[index];
            //               return Padding(
            //                 padding: const EdgeInsets.only(bottom: 8.0),
            //                 child: Row(
            //                   children: [
            //                     ClipRRect(
            //                       borderRadius: BorderRadius.circular(4),
            //                       // child: Image.network(
            //                       //   item['cover']!,
            //                       //   width: 40,
            //                       //   height: 40,
            //                       //   fit: BoxFit.cover,
            //                       // ),
            //                     ),
            //                     const SizedBox(width: 8),
            //                     Expanded(
            //                       child: Column(
            //                         crossAxisAlignment: CrossAxisAlignment.start,
            //                         children: [
            //                           Text(
            //                             item['title']!,
            //                             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            //                             overflow: TextOverflow.ellipsis,
            //                           ),
            //                           Text(
            //                             item['artist']!,
            //                             style: const TextStyle(fontSize: 16, color: Colors.grey),
            //                             overflow: TextOverflow.ellipsis,
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               );
            //             },
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),

            // Right: Up Next section (hardcoded)

// Padding(
//   padding: const EdgeInsets.only(right: 150, left: 60),
//   child: Container(
//     width: 300,
//     height: 400,
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(8),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black.withOpacity(0.1),
//           blurRadius: 6,
//           offset: const Offset(0, 4),
//         )
//       ],
//     ),
//     padding: const EdgeInsets.all(20),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("$expression" + " Tunes",
//           //'Up Next',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//             color: Colors.amber[700],
//             decoration: TextDecoration.underline,
//             decorationThickness: 2,
//           ),
//         ),
//         const SizedBox(height: 10),
       
//         Expanded(
//           child: ListView.builder(
//             itemCount: upNextList.length,
//             itemBuilder: (context, index) {
//               final item = upNextList[index];
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 8.0),
//                 child: Row(
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(4),
//                       // child: Image.network(
//                       //   item['cover']!,
//                       //   width: 40,
//                       //   height: 40,
//                       //   fit: BoxFit.cover,
//                       // ),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             item['title']!,
//                             style: const TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.w600),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           Text(
//                             item['artist']!,
//                             style: const TextStyle(
//                                 fontSize: 16, color: Colors.grey),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     ),
//   ),
// ),



//           ],
//         ),
//       ),
//     );
//   }
// }
