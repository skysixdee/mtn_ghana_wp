import 'package:mtn_ghana_wp/files/controllers/my_tune_controllers/my_playing_tune_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/model/navigation_header_model.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_alert_popup.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_screen_header_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/get_navigation_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/loading_indicator.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/navigation_header_view.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/screens/my_tune_screen/header_view/my_tune_header_view.dart';
import 'package:mtn_ghana_wp/files/screens/my_tune_screen/my_music_box_view/my_music_box_view.dart';
import 'package:mtn_ghana_wp/files/screens/my_tune_screen/my_tune_view/my_tune_view.dart';
import 'package:mtn_ghana_wp/files/screens/my_tune_screen/playing_tune_view/playing_tune_view.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/images.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MyTuneScreen extends StatelessWidget {
  MyTuneScreen({super.key});
  final MyPlayingTuneController playingTuneController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: ResponsiveBuilder(
        builder: (context, si) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    CustomScreenHeaderView(
                      imageName: myTuneHeaderPng,
                      title: setYourTuneStr,
                      subTitle: customiseYourTuneStr,
                      height: 300,
                    ),
                    // const MyTuneHeaderView(),
                  ],
                ),
              ),
              SliverAppBar(
                toolbarHeight: si.isMobile ? 0 : 50,
                //backgroundColor: red,
                pinned: true,
                flexibleSpace: getNavigationView(myTunezStr),
              ),
              SliverToBoxAdapter(
                child: listView(si),
              ),
            ],
          ); //listView(si);
        },
      ),
    );
  }

  ListView listView(SizingInformation si) {
    return ListView(
      shrinkWrap: true,
      primary: true,
      children: [
        //getNavigationView(myTunezStr),
        const SizedBox(height: 1),
        playingTuneHeader(si),
        SizedBox(height: si.isMobile ? 20 : 30),
        PlayingTuneView(),
        const SizedBox(height: 20),
        myTuneHeader(si, activeTunezStr, howToPlaySelctedStr, () {
          openAlertPopup(
              message: myTunePopupMessageStr, textAlign: TextAlign.left);
        }),
        SizedBox(height: si.isMobile ? 20 : 30),
        MyTuneView(),
        const SizedBox(height: 20),
        myTuneHeader(si, myMusicBoxStr, howToPlayMusicBixStr, () {
          openAlertPopup(
            message: myMusicBoxPopupMessageStr,
          );
        }),
        SizedBox(height: si.isMobile ? 20 : 30),
        MyMusicBoxView(),
        SizedBox(height: si.isMobile ? 20 : 50),
      ],
    );
  }

  Widget playingTuneHeader(SizingInformation si) {
    return Container(
      height: 60,
      color: lightGrey,
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
                  return playingTuneController.switchingShuffle.value
                      ? loadingIndicator(radius: 12, width: 60)
                      : CupertinoSwitch(
                          activeColor: yellow,
                          value: playingTuneController.isShuffleOn.value,
                          onChanged: (value) {
                            playingTuneController.enabelDispableShuffle();
                          });
                }),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget myTuneHeader(
      SizingInformation si, String heading, String message, Function() onTap) {
    return Container(
      color: lightGrey,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: si.isMobile ? 8 : 25, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: heading,
              fontSize: si.isMobile ? 16 : 20,
              fontName: FontName.bold,
            ),
            Row(
              children: [
                CustomText(
                  title: message,
                  fontSize: si.isMobile ? 10 : 14,
                  color: grey,
                ),
                GenericButton(
                  height: 24,
                  bgColor: transparent,
                  padding: const EdgeInsets.only(left: 8),
                  trailingIcon: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 10,
                    color: yellow,
                  ),
                  title: learnMoreStr,
                  fontSize: si.isMobile ? 10 : 14,
                  fontName: FontName.regular,
                  textColor: yellow,
                  onTap: () {
                    onTap();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
