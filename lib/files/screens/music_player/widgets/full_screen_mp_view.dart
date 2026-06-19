import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_ghana_wp/files/api_calls/add_to_wishlist_api.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_alert_popup.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_image.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/screens/music_player/widgets/mp_play_button.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:mtn_ghana_wp/main.dart';

import 'package:responsive_builder/responsive_builder.dart';

class FullScreenMpView extends StatelessWidget {
  const FullScreenMpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appCont.isDarkTheme.value ? blackTest : whiteD,
      child: Stack(
        alignment: AlignmentGeometry.topRight,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: ResponsiveBuilder(
              builder: (context, si) {
                return si.isMobile
                    ? ListView(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        shrinkWrap: true,
                        children: [
                          playerView(true),
                          playingTitleWidget(si),
                          const SizedBox(height: 20),
                          upcomingList(si),
                          artistListMobileView(si),
                          SizedBox(height: 20),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: ListView(
                              children: [
                                Wrap(
                                  spacing: 20,
                                  // spacing: 10,
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: 300, child: playerView(false)),
                                    artistListDesktopView(si),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Flexible(child: upcomingList(si))
                        ],
                      );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GenericButton(
                  padding: EdgeInsets.zero,
                  width: 40,
                  leadingIcon: Icon(Icons.fullscreen_exit),
                  onTap: () {
                    pCont.isMusicPlayerFullScreen.value = false;
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget upcomingList(SizingInformation si) {
    return SizedBox(
      width: si.isMobile ? null : 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            colorD: whiteD,
            title: upcomingStr,
            fontName: FontName.bold,
            fontSize: si.isMobile ? 16 : 20,
          ),
          SizedBox(height: 10),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              physics: si.isMobile ? NeverScrollableScrollPhysics() : null,
              itemCount: pCont.tuneList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color:
                                appCont.isDarkTheme.value ? grey : transparent),
                        color: appCont.isDarkTheme.value ? whiteD : lightGrey,
                        borderRadius: BorderRadius.circular(4)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          pCont.playUrl(pCont.tuneList[index]);
                        },
                        child: Row(
                          spacing: 8,
                          children: [
                            Obx(
                              () {
                                return SizedBox(
                                  height: 38,
                                  width: 38,
                                  child: index != pCont.currentIndex.value
                                      ? customImage(
                                          cornerRadius: 4,
                                          url: pCont.tuneList[index]
                                                  .toneIdpreviewImageUrl ??
                                              "",
                                        )
                                      : InkWell(
                                          onTap: () {
                                            if (pCont.isPlaying.value) {
                                              pCont.pauseAudio();
                                            } else {
                                              pCont.playAudio();
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: red,
                                            ),
                                            child: Icon(
                                                pCont.isPlaying.value
                                                    ? Icons.pause_rounded
                                                    : Icons.play_arrow_rounded,
                                                color: white,
                                                size: 20),
                                          ),
                                        ),
                                );
                              },
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  colorD: black,
                                  fontName: FontName.semiBold,
                                  fontSize: 12,
                                  title: pCont.tuneList[index].toneName ?? "",
                                ),
                                CustomText(
                                  colorD: black,
                                  fontName: FontName.regular,
                                  fontSize: 10,
                                  title: pCont.tuneList[index].artistName ?? "",
                                )
                              ],
                            ),
                            const Spacer(),
                            GenericButton(
                              bgColor: transparent,
                              width: 30,
                              padding: const EdgeInsets.all(0),
                              leadingIcon: const Icon(
                                Icons.play_arrow_rounded,
                              ),
                              onTap: () {
                                pCont.playUrl(pCont.tuneList[index]);
                              },
                            ),
                            GenericButton(
                              bgColor: transparent,
                              width: 30,
                              padding: const EdgeInsets.all(0),
                              leadingIcon: const Icon(
                                Icons.favorite_border,
                              ),
                              onTap: () {
                                if (StoreManager.isLoggedIn) {
                                  addToWishlistApi(pCont.toneinfo.value);
                                } else {
                                  openAlertPopup(
                                      message:
                                          thisFeatureIsAvailableForLoggedinStr);
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget artistListDesktopView(SizingInformation si) {
    final uniqueArtists =
        pCont.tuneList.map((e) => e.artistName ?? "").toSet().toList();
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        playingTitleWidget(si),
        SizedBox(height: 20),
        CustomText(
          colorD: whiteD,
          fontName: FontName.bold,
          fontSize: 16,
          title: artistsStr,
        ),
        SizedBox(
          width: 400,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: uniqueArtists.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  pCont.isMusicPlayerFullScreen.value = false;
                  context.goNamed(artistTuneRoute,
                      queryParameters: {'artistName': uniqueArtists[index]});
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                  child: Row(
                    spacing: 20,
                    children: [
                      Flexible(
                        child: CustomText(
                          colorD: whiteD,
                          title: uniqueArtists[index],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 13,
                        color: appCont.isDarkTheme.value ? offWhite : black,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget artistListMobileView(SizingInformation si) {
    final uniqueArtists =
        pCont.tuneList.map((e) => e.artistName ?? "").toSet().toList();
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //playingTitleWidget(),
        SizedBox(height: 20),
        CustomText(
          colorD: whiteD,
          fontName: FontName.bold,
          fontSize: si.isMobile ? 14 : 16,
          title: artistsStr,
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: uniqueArtists.length,
            itemBuilder: (context, index) {
              return InkWell(
                focusColor: transparent,
                hoverColor: transparent,
                highlightColor: transparent,
                splashColor: transparent,
                onTap: () {
                  pCont.isMusicPlayerFullScreen.value = false;
                  context.goNamed(artistTuneRoute,
                      queryParameters: {'artistName': uniqueArtists[index]});
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 8.0,
                  ),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                        decoration: BoxDecoration(
                            color: yellow,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(
                              title: uniqueArtists[index],
                              color: white,
                              colorD: blackD,
                              fontSize: 12,
                              fontName: FontName.semiBold,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Obx playingTitleWidget(SizingInformation si) {
    return Obx(
      () {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              colorD: whiteD,
              fontName: FontName.bold,
              fontSize: si.isMobile ? 13 : 16,
              title: pCont.toneinfo.value.toneName,
            ),
            CustomText(
              fontName: FontName.regular,
              title: pCont.toneinfo.value.artistName,
              color: black,
              colorD: whiteD,
              fontSize: si.isMobile ? 12 : null,
            )
          ],
        );
      },
    );
  }

  Widget playerView(bool isMobile) {
    return Column(
      children: [
        SizedBox(
          height: isMobile ? 300 : 250,
          child: Center(
            child: Obx(
              () {
                return customImage(
                    cornerRadius: 4,
                    url: pCont.toneinfo.value.toneIdpreviewImageUrl ?? "");
              },
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: white,
          ),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //shareButton(),
              previousButton(),
              playButtonButton(),
              nextButton(),
              wishlistButton()
            ],
          ),
        )
      ],
    );
  }

  Widget shareButton() {
    return GenericButton(
      width: 40,
      bgColor: transparent,
      padding: EdgeInsets.zero,
      leadingIcon: const Icon(
        Icons.share,
        size: 18,
      ),
      onTap: () {
        print("object");
      },
    );
  }

  Widget previousButton() {
    return GenericButton(
      width: 40,
      bgColor: transparent,
      padding: EdgeInsets.zero,
      leadingIcon: const Icon(
        Icons.skip_previous_rounded,
        size: 22,
      ),
      onTap: () {
        pCont.playPrevious();
      },
    );
  }

  Widget playButtonButton() {
    return MpPlayButton(
        padding: EdgeInsets.zero,
        width: 40,
        bgColor: transparent,
        tuneList: pCont.tuneList,
        tuneInfo: pCont.toneinfo.value);
  }

  Widget nextButton() {
    return GenericButton(
      width: 40,
      bgColor: transparent,
      padding: EdgeInsets.zero,
      leadingIcon: const Icon(
        Icons.skip_next_rounded,
        size: 22,
      ),
      onTap: () {
        pCont.playNext();
      },
    );
  }

  Widget wishlistButton() {
    return GenericButton(
      width: 40,
      bgColor: transparent,
      padding: EdgeInsets.zero,
      leadingIcon: const Icon(
        Icons.favorite_border,
        size: 18,
      ),
      onTap: () {
        print("Wishlist button tapped");
        if (StoreManager.isLoggedIn) {
          addToWishlistApi(pCont.toneinfo.value);
        } else {
          openAlertPopup(message: thisFeatureIsAvailableForLoggedinStr);
        }
      },
    );
  }
}
