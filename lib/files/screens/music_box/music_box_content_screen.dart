import 'package:mtn_ghana_wp/files/controllers/music_box_controller.dart';
import 'package:mtn_ghana_wp/files/enums/custpm_screen_type.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/buy_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/buy_music_box_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/play_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_scroll_view/generic_scroll_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/generic_grid_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/get_navigation_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/loading_indicator.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/tune_card.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MusicBoxContentScreen extends StatelessWidget {
  MusicBoxContentScreen({
    super.key,
    required this.id,
    required this.boxName,
    required this.boxImage,
  });
  final String id;
  final String boxName;
  final String boxImage;
  final MusicBoxController con = Get.find();
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Obx(
          () {
            return GenericScrollView(
              onlyGrid: si.isMobile,
              isLoading: con.isLoadingContent.value,
              itemCount: con.musicBoxContentList.length,
              sliverAppBar: getNavigationView(musicBoxStr,
                  rightButton: buyButton(
                      isMusicBox: true,
                      TuneInfo(
                          toneId: id,
                          toneName: boxName,
                          toneIdpreviewImageUrl: ""),
                      padding: EdgeInsets.symmetric(horizontal: 16))),
              //buyMusicBoxButton()),
              //),
              builder: (p0) {
                return TuneCard(
                  customScreenType: CustomScreenType.musicContent,
                  tuneList: con.musicBoxContentList,
                  moreButton: const SizedBox(),
                  info: con.musicBoxContentList[p0],
                  bottomButtonChild: playButton(
                      con.musicBoxContentList[p0], con.musicBoxContentList,
                      isHideBuyButton: false),
                );
              },
            );
          },
        );
      },
    );
  }
}
