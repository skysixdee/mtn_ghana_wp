import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/controllers/new_player_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/enums/my_player_state.dart';
import 'package:mtn_ghana_wp/files/model/popover_menu_model.dart';
import 'package:mtn_ghana_wp/files/popup_views/generic_popup.dart';
import 'package:mtn_ghana_wp/files/popup_views/social_sharing_popup.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/buy_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_image.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/generic_popover.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';

import 'package:responsive_builder/responsive_builder.dart';

class MinimizedPlayerView extends StatelessWidget {
  MinimizedPlayerView({super.key});
  final PlayerController cont = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 8,
              color: white.withValues(alpha: 0.85),
            ),
            Container(
              color: black.withValues(alpha: 0.6),
              height: minPlayerHeight,
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Center(child: mainContainer()),
              ),
            ),
          ],
        ),
        sliderTheme(context),
      ],
    );
  }

  Widget mainContainer() {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Obx(
          () {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: leftWidget()),
                if (!sizingInformation.isMobile)
                  Expanded(
                      child: !cont.isPlayerMaxSize.value
                          ? centerWidget(sizingInformation)
                          : const SizedBox()),
                sizingInformation.isMobile
                    ? rightWidget(sizingInformation)
                    : Expanded(child: rightWidget(sizingInformation)),
              ],
            );
          },
        );
      },
    );
  }

  SliderTheme sliderTheme(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: yellow,
        inactiveTrackColor: black.withValues(alpha: 0.4),
        thumbColor: yellow,
        trackHeight: 3.0, // Set the height of the track
        thumbShape:
            const RoundSliderThumbShape(enabledThumbRadius: 8.0), // Thumb size
        overlayShape:
            const RoundSliderOverlayShape(overlayRadius: 1.0), // Overlay size
      ),
      child: Obx(
        () {
          return Slider(
            value: cont.currentPosition.value,
            min: 0,
            max: cont.totalDuration.value,
            onChanged: (value) {
              print(" cont.totalDuration.value = ${cont.totalDuration.value}");
              cont.seekAudio(value);
            },
          );
        },
      ),
    );
  }

  Widget leftWidget() {
    return SizedBox(
      height: 50,
      child: Obx(
        () {
          return Row(
            spacing: 8,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: customImage(url: cont.info.value.toneIdpreviewImageUrl),
              ),
              Flexible(
                child: CustomText(
                  title: cont.info.value.toneName ?? '',
                  color: white,
                  fontSize: 12,
                  fontName: FontName.semiBold,
                ),
              ),
              const Icon(
                Icons.music_note,
                size: 18,
                color: white,
              ),
              if (!cont.isHideBuyButton.value)
                buyButton(cont.info.value,
                    padding: const EdgeInsets.symmetric(horizontal: 12))
              // CustomText(
              //   title: "Add buy button here",
              // )
              // buyButton(cont.info.value,
              //     padding: EdgeInsets.symmetric(horizontal: 20))
            ],
          );
        },
      ),
    );
  }

  Widget centerWidget(SizingInformation si) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // GenericButton(
          //   title: '',
          //   bgColor: transparent,
          //   leadingIcon: Obx(
          //     () {
          //       return Icon(
          //         Icons.shuffle,
          //         color: cont.isShuffle.value ? red : white,
          //       );
          //     },
          //   ),
          //   onTap: () {
          //     cont.shuffleAction();
          //   },
          // ),
          // SizedBox(width: 4),
          GenericButton(
            bgColor: transparent,
            leadingIcon: const Icon(
              Icons.skip_previous,
              color: white,
            ),
            onTap: () {
              cont.previousButton();
              print("tapped");
            },
          ),
          const SizedBox(width: 4),
          GenericButton(
            radius: 20,
            bgColor: transparent,
            borderColor: white,
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(0),
            leadingIcon: Obx(
              () {
                return playIconLoadBasedOnState(cont.myPlayerState.value,
                    iconColor: white);
              },
            ),
            onTap: cont.myPlayerState.value == MyPlayerState.loading
                ? null
                : () {
                    cont.playPause();
                    print("tapped");
                  },
          ),
          const SizedBox(width: 4),
          GenericButton(
            bgColor: transparent,
            leadingIcon: const Icon(
              Icons.skip_next,
              color: white,
            ),
            onTap: () {
              cont.nextButton();
              print("tapped");
            },
          ),
          // SizedBox(width: 4),
          // GenericButton(
          //   bgColor: transparent,
          //   title: '',
          //   leadingIcon: Obx(
          //     () {
          //       return Icon(
          //         Icons.repeat,
          //         color: cont.isRepeat.value ? red : white,
          //       );
          //     },
          //   ),
          //   onTap: () {
          //     cont.repeatAction();
          //     print("tapped");
          //   },
          // ),
        ],
      ),
    );
  }

  Widget rightWidget(SizingInformation si) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (!si.isMobile)
            Obx(
              () {
                return GenericButton(
                  bgColor: transparent,
                  textColor: white,
                  fontSize: 12,
                  fontName: FontName.semiBold,
                  title: "${cont.playingIndex.value + 1}/${cont.list.length}",
                  leadingIcon: const Padding(
                    padding: EdgeInsets.only(left: 4.0),
                    child: Icon(
                      Icons.volume_up,
                      color: white,
                    ),
                  ),
                  onTap: () {
                    print("tapped");
                  },
                );
              },
            ),
          if (!si.isMobile)
            Obx(
              () {
                return Visibility(
                    visible: !cont.isPlayerMaxSize.value, child: moreButton());
              },
            ),
          GenericButton(
            padding: const EdgeInsets.all(0),
            height: 30,
            width: 30,
            bgColor: transparent,
            leadingIcon: cont.isPlayerMaxSize.value
                ? const Icon(
                    Icons.fullscreen_exit,
                    color: white,
                  )
                : const Icon(
                    Icons.fullscreen,
                    color: white,
                  ),
            onTap: () async {
              print("tapped");
              cont.maximizePlayer(!cont.isPlayerMaxSize.value);
              //cont.isPlayerMaxSize.value = !cont.isPlayerMaxSize.value;
              //await Future.delayed(const Duration(seconds: 1));
              //CustomAudioPlayer.instance.play();
            },
          ),
          if (!si.isMobile) const SizedBox(width: 2),
          GenericButton(
            bgColor: transparent,
            padding: const EdgeInsets.all(0),
            height: 30,
            width: 30,
            leadingIcon: const Icon(
              Icons.close,
              color: white,
            ),
            onTap: () {
              cont.stop();

              //cont.isPlayerMaxSize.value = false;
              cont.maximizePlayer(false);
              cont.isPlayerVisible.value = false;
            },
          )
        ],
      ),
    );
  }

  ResponsiveBuilder moreButton() {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return GenericButton(
          bgColor: transparent,
          leadingIcon: const Icon(
            Icons.more_horiz,
            color: white,
          ),
          onTap: () {
            genericPopover(
              width: 140,
              context,
              [PopoverMenuModel(shareStr), PopoverMenuModel(addToWishlistStr)],
              onTap: (PopoverMenuModel model, int index) {
                if (model.title == shareStr) {
                  genericPopup(SocialSharingPopup(info: cont.info.value));
                } else if (model.title == addToWishlistStr) {
                  // addToWishlistApi(cont.info.value);
                  print("Add to wishlist api call here");
                }
                print("model is ${model.title}\n");
                print("model is $index");
              },
            );
          },
        );
      },
    );
  }
}

Widget playIconLoadBasedOnState(MyPlayerState state,
    {Color iconColor = black}) {
  if (state == MyPlayerState.completed) {
    return Icon(
      Icons.play_arrow_rounded,
      color: iconColor,
    );
  } else if (state == MyPlayerState.playing) {
    return Icon(
      Icons.pause,
      color: iconColor,
    );
  } else if (state == MyPlayerState.loading) {
    return CupertinoActivityIndicator(
      radius: 12,
      color: iconColor,
    );
  } else if (state == MyPlayerState.pause) {
    return Icon(
      Icons.play_arrow_rounded,
      color: iconColor,
    );
  } else {
    return Icon(
      Icons.play_arrow_rounded,
      color: iconColor,
    );
  }
}
