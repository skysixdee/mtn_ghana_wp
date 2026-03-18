import 'package:encrypt/encrypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:mtn_ghana_wp/files/common/decode_html_text.dart';
import 'package:mtn_ghana_wp/files/controllers/my_tune_controllers/my_playing_tune_controller_new.dart';
import 'package:mtn_ghana_wp/files/player_view/new_player_controller.dart';

import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/model/list_setting_model.dart';
import 'package:mtn_ghana_wp/files/model/music_box_sc_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/play_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_image.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_scroll_view/combined_grid.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/loading_indicator.dart';
import 'package:mtn_ghana_wp/files/screens/my_tune_screen/playing_tune_view/widgets/playing_tune_card.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PlayingTuneViewNew extends StatefulWidget {
  const PlayingTuneViewNew({super.key});

  @override
  State<PlayingTuneViewNew> createState() => _PlayingTuneViewNewState();
}

class _PlayingTuneViewNewState extends State<PlayingTuneViewNew> {
  MyPlayingTuneControllerNew con = Get.find();
  PlayerController pCont = Get.find();
  @override
  void initState() {
    //con.getListSetting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Obx(
          () {
            return con.isLoading.value
                ? loadingIndicator()
                : listView(sizingInformation);
          },
        );
      },
    );
  }

  Widget listView(SizingInformation si) {
    return Column(
      children: [
        playingTuneHeader(si),
        const SizedBox(height: 20),
        Obx(
          () {
            return CombinedGrid(
                physics: NeverScrollableScrollPhysics(),
                itemCount: con.settingsList.length,
                isLoading: con.isLoading.value,
                cardWidth: 220,
                aspectRatio: 0.75,
                padding: null,
                builder: (p0) {
                  final v = con.settingsList[p0];
                  return card(v);
                },
                onTap: (p1) => {});
          },
        ),
      ],
    );
  }

  Container card(SettingsList v) {
    bool isMusicBox =
        con.myMusicBoxList.any((TuneInfo inf) => inf.toneId == v.contentId);
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(color: lightGrey, blurRadius: 3, spreadRadius: 1)
        ],
        borderRadius: BorderRadius.circular(8),
        color: white,
      ),
      child: Column(
        children: [
          Expanded(child: toneImage(v, isMusicBox)),
          toneDetail(v, isMusicBox),
        ],
      ),
    );
  }

  Padding toneDetail(SettingsList v, bool isMisicBox) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
      child: Row(
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2,
              children: [
                callerTypeBuilder(v, isMisicBox),
                Container(
                  color: lightGrey,
                  height: 1,
                  width: double.maxFinite,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            maxLine: 1,
                            title: decodeHtmlEntities(v.contentName ?? ''),
                            fontName: FontName.bold,
                          ),
                          CustomText(
                            maxLine: 1,
                            title: isMisicBox
                                ? musicBoxStr
                                : decodeHtmlEntities(v.artistName ?? ''),
                            fontName: FontName.semiBold,
                            color: black,
                            fontSize: 12,
                          ),
                        ],
                      ),
                    ),
                    if (con.settingsList.length > 1)
                      GenericButton(
                        height: 30,
                        width: 30,
                        padding: const EdgeInsets.all(0),
                        bgColor: transparent,
                        leadingIcon: const Icon(
                          size: 18,
                          Icons.delete,
                          color: red,
                        ),
                        onTap: () {
                          con.deleteTune(v);
                          print("tapped");
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget callerTypeBuilder(SettingsList v, bool isMusicBox) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              fontName: FontName.regular,
              color: grey,
              title: serviceType(v.serviceName ??
                  ''), //v.bMsisdn == null ? "Caller" : "Dedicated To",
            ),
            CustomText(
              title: serviceName(v),
            )
          ],
        ),
        CustomText(
          title: "Full\nDay",
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  String serviceType(String serviceName) {
    if (serviceName == 'Group') {
      return serviceName;
    } else if (serviceName == 'AllCaller') {
      return serviceName;
    } else if (serviceName == 'Dedication') {
      return serviceName;
    } else {
      return '';
    }
  }

  String serviceName(SettingsList v) {
    if (v.serviceName == 'Group') {
      return v.groupId ?? '';
    } else if (v.serviceName == 'AllCaller') {
      return v.serviceName ?? '';
    } else if (v.serviceName == 'Dedication') {
      return v.bMsisdn ?? '';
    } else {
      return '';
    }
  }

  Widget toneImage(SettingsList info, bool isMusicBox) {
    String imageName = (info.contentName ?? '').replaceAll(RegExp(r'\s+'), '');
    TuneInfo inf = TuneInfo(
      toneIdStreamingUrl: info.contentStreamingUrl ?? "",
      toneId: info.contentId,
      artistName: info.albumName,
      albumName: info.albumName,
      categoryId: '',
    );
    return Stack(
      alignment: Alignment.center,
      children: [
        customImage(
            url: isMusicBox ? null : info.contentPreviewImageUrl,
            imageName:
                isMusicBox ? 'assets/music_box_pngs/$imageName.png' : null),
        if (!isMusicBox)
          Obx(
            () {
              return GenericButton(
                bgColor: white,
                borderColor: black,
                padding: const EdgeInsets.all(0),
                width: 30,
                height: 30,
                // leadingIcon: Icon(
                //   pCont.playingToneId.value == info.contentId
                //       ? Icons.pause
                //       : Icons.play_arrow_rounded,
                //   size: pCont.playingToneId.value == info.contentId ? 20 : 22,
                //   color: black,
                // ),
                onTap: () {
                  //pCont.playUrl(inf);
                },
              );
            },
          ),
        //playButton(TuneInfo())
      ],
    );
  }

  Widget playingTuneHeader(SizingInformation si) {
    return Container(
      height: 60,
      color: isDarkTheme(context) ? blackTest : lightGrey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: si.isMobile ? 8.0 : 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              title: cusrrentlyPlayigToStr,
              fontName: FontName.bold,
              fontSize: si.isMobile ? 14 : 20,
            ),
            Row(
              children: [
                CustomText(
                  title: shuffleStr,
                  color: grey,
                  fontSize: si.isMobile ? 12 : 16,
                ),
                Obx(() {
                  return con.switchingShuffle.value
                      ? loadingIndicator(radius: 12, width: 60)
                      : CupertinoSwitch(
                          activeColor: yellow,
                          value: con.isShuffleEnable.value,
                          onChanged: (value) {
                            con.enabelDispableShuffle();
                          });
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
