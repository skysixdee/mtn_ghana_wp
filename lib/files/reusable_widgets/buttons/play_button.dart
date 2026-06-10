import 'package:mtn_ghana_wp/files/enums/my_player_state.dart';
import 'package:mtn_ghana_wp/files/popup_views/gift_popup_view.dart';
import 'package:flutter/material.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';

import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mtn_ghana_wp/main.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';

// Widget playButton(TuneInfo info, {Function()? onTap}) {
//   return
//   // CustomText(
//   //   title: "Add play button here",
//   // );
// }

// Widget playButton(TuneInfo info, List<TuneInfo> tuneList,
//     {Function()? onTap, bool isRound = false, bool? isHideBuyButton = false}) {
//   //PlayerController pCont = Get.find();
//   //pCont.isHideBuyButton.value = isHideBuyButton ?? false;
//   return Text("replace ");
//   // ResponsiveBuilder(
//   //   builder: (context, si) {
//   //     return Obx(
//   //       () {
//   //         return GenericButton(
//   //           width: 36,
//   //           height: 36,
//   //           radius: 18,

//   //           padding: EdgeInsets.zero,
//   //           borderColor: grey,
//   //           bgColor: isDarkTheme(context) ? whiteD : white,
//   //           fontName: si.isMobile ? FontName.regular : FontName.bold,
//   //           leadingIcon: Obx(
//   //             () {
//   //               return pCont.info.value.toneId == info.toneId
//   //                   ? playIconLoadBasedOnState(pCont.myPlayerState.value)
//   //                   : playIconLoadBasedOnState(MyPlayerState.completed);
//   //             },
//   //           ),
//   //           //title: playStr,
//   //           onTap: pCont.info.value.toneId == info.toneId
//   //               ? () {
//   //                   pCont.playPause();
//   //                   //CustomAudioPlayer.instance.pause();
//   //                 }
//   //               : (pCont.myPlayerState.value == MyPlayerState.loading)
//   //                   ? null
//   //                   : () {
//   //                       try {
//   //                         print(
//   //                             "tuneList.first.toneId ===========${tuneList.first.toneId}");
//   //                       } catch (e) {}
//   //                       print("urls ===========${tuneList.length}");

//   //                       print("urls ===========${info.toneId}");
//   //                       pCont.isPlayerVisible.value = true;
//   //                       int ind =
//   //                           tuneList.indexWhere((v) => v.toneId == info.toneId);

//   //                       print("index is $ind");
//   //                       if (ind < 0) {
//   //                         print("playing index showing below 1 ");
//   //                         return;
//   //                       }
//   //                       pCont.playList(tuneList, ind);

//   //                       onTap?.call();
//   //                     },
//   //         );
//   //       },
//   //     );
//   //   },
//   // );
//   //
// }
// /*
// Widget playButton(TuneInfo info, {Function()? onTap}) {
//   PlayerController pCont = Get.find();
//   return ResponsiveBuilder(
//     builder: (context, si) {
//       return Obx(
//         () {
//           return GenericButton(
//             isStopPlay: false,
//             padding: EdgeInsets.zero,
//             borderColor:black, //red,
//             bgColor: white,
//             fontName: si.isMobile ? FontName.regular : FontName.bold,
//             leadingIcon: Icon(
//               pCont.playingToneId.value == info.toneId
//                   ? Icons.pause
//                   : Icons.play_arrow_rounded,
//               size: pCont.playingToneId.value == info.toneId ? 20 : 22,
//             ),
//             title: playStr,
//             onTap: () {
//               pCont.playUrl(info);
//               if (onTap != null) {
//                 onTap();
//               }
//             },
//           );
//         },
//       );
//     },
//   );
//   //
// }
// */
