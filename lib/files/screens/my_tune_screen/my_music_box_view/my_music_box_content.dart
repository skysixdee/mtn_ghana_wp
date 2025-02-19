import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/controllers/music_box_controller.dart';
import 'package:mtn_ghana_wp/files/enums/custpm_screen_type.dart';
import 'package:mtn_ghana_wp/files/model/navigation_header_model.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/buy_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/play_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_scroll_view/generic_scroll_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/get_navigation_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/tune_card.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';

class MyMusicBoxContent extends StatelessWidget {
  MyMusicBoxContent(
      {super.key,
      required this.toneid,
      required this.toneName,
      required this.imgUrl});
  final String toneid;
  final String toneName;
  final String imgUrl;
  final MusicBoxController con = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return GenericScrollView(
          isLoading: con.isLoadingContent.value,
          itemCount: con.musicBoxContentList.length,
          sliverAppBar: getNavigationView(myMusicBoxStr,
              rightButton: const SizedBox(),
              navList: [
                NavigationHeaderModel(homeStr, homeRoute),
                NavigationHeaderModel(myMusicBoxStr, myTunesRoute),
                NavigationHeaderModel(toneName, ""),
              ]),
          builder: (p0) {
            return TuneCard(
              customScreenType: CustomScreenType.musicContent,
              tuneList: con.musicBoxList,
              moreButton: const SizedBox(),
              info: con.musicBoxContentList[p0],
              bottomButtonChild: playButton(con.musicBoxContentList[p0]),
            );
          },
        );
      },
    );
  }
}
