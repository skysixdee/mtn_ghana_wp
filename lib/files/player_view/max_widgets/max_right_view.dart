import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/player_view/new_player_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/enums/my_player_state.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_image.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:mtn_ghana_wp/files/player_view/minimized_player_view.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';

import 'package:responsive_builder/responsive_builder.dart';

class MaxRightView extends StatelessWidget {
  final PlayerController playerController = Get.find();
  MaxRightView({super.key});
  final RxInt selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        toggle(context),
        SizedBox(height: 8),
        Flexible(child: listView()),
      ],
    );
  }

  Widget toggle(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: upNextButton(),
            ),
            // Expanded(
            //   child: mightLikeButton(),
            // ),
          ],
        ),
        SizedBox(height: 1),
        SizedBox(
          height: 4,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: grey,
                height: 1,
              ),
              Obx(
                () {
                  return Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: selectedIndex.value == 0
                              ? (isDarkTheme(context) ? yellowD : yellow)
                              : transparent,
                          height: 4,
                        ),
                      ),
                      // Expanded(
                      //   child: Container(
                      //     color:
                      //         selectedIndex.value == 1 ? yellow : transparent,
                      //     height: 4,
                      //   ),
                      // ),
                    ],
                  );
                },
              )
            ],
          ),
        )
      ],
    );
  }

  Widget mightLikeButton() {
    return Obx(
      () {
        return GenericButton(
          radius: 2,
          title: youMisghtLikeStr,
          bgColor: transparent,
          fontName: selectedIndex.value == 1 ? FontName.bold : FontName.regular,
          onTap: () {
            selectedIndex.value = 1;
            print("tapped");
          },
        );
      },
    );
  }

  Widget upNextButton() {
    return Obx(
      () {
        return GenericButton(
          radius: 2,
          fontSize: 18,
          title: upNextStr,
          fontName: selectedIndex.value == 0 ? FontName.bold : FontName.regular,
          bgColor: transparent,
          onTap: () {
            print("tapped");
            selectedIndex.value = 0;
          },
        );
      },
    );
  }

  Widget listView() {
    return Obx(
      () {
        return ListView.builder(
          padding: const EdgeInsets.only(right: 12),
          itemCount: playerController.list.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: pleayerTuneCard(
                    playerController, playerController.list[index], index));
          },
        );
      },
    );
  }

  Widget arrange(String toneId) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GenericButton(
        padding: EdgeInsets.zero,
        leadingIcon: Obx(
          () {
            return playerController.info.value.toneId == toneId
                ? const Icon(
                    Icons.play_arrow_rounded,
                    color: red,
                  )
                : const Icon(Icons.menu);
          },
        ),
        onTap: () {
          print("object");
        },
      ),
    );
  }
}

Widget pleayerTuneCard(PlayerController controller, TuneInfo info, int index) {
  return InkWell(onTap: () {
    controller.playAtIndex(index);
  }, child: ResponsiveBuilder(
    builder: (context, si) {
      return SizedBox(
        height: 50,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Padding(
                padding: EdgeInsets.all(si.isMobile ? 4.0 : 0),
                child: Stack(
                  children: [
                    customImage(
                        cornerRadius: 4, url: info.toneIdpreviewImageUrl),
                    _playingOverLayIndicator(context, controller, info)
                  ],
                ),
              ),
            ),
            const SizedBox(width: 4),
            Flexible(child: _toneInfo(info))
          ],
        ),
      );
    },
  ));
}

Obx _playingOverLayIndicator(
    BuildContext context, PlayerController controller, TuneInfo info) {
  return Obx(
    () {
      return (controller.info.value.toneId == info.toneId)
          ? InkWell(
              onTap: controller.myPlayerState.value == MyPlayerState.loading
                  ? () {
                      print("already loading");
                    }
                  : () {
                      if (controller.info.value.toneId == info.toneId) {
                        controller.playPause();
                      }
                    },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: isDarkTheme(context) ? yellowD : yellow,
                ),
                child: Center(child: Obx(
                  () {
                    return playIconLoadBasedOnState(
                        controller.myPlayerState.value);
                  },
                )
                    // Icon(
                    //   controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                    //   size: controller.isPlaying.value ? 20 : 18,
                    //   color: black,
                    // ),
                    ),
              ),
            )
          : const SizedBox();
    },
  );
}

Widget _toneInfo(TuneInfo info) {
  return ResponsiveBuilder(
    builder: (context, si) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            isSelectable: false,
            title: info.toneName,
            color: black,
            colorD: si.isMobile ? whiteD : black,
            maxLine: 1,
            fontSize: si.isMobile ? 12 : null,
            fontName: si.isMobile ? FontName.semiBold : FontName.bold,
          ),
          CustomText(
            isSelectable: false,
            maxLine: 1,
            color: black,
            colorD: si.isMobile ? whiteD : black,
            title: info.artistName,
            fontSize: si.isMobile ? 11 : null,
            fontName: FontName.regular,
          )
        ],
      );
    },
  );
}
