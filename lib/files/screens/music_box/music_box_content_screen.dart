import 'package:etisalat/files/controllers/music_box_controller.dart';
import 'package:etisalat/files/enums/custpm_screen_type.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:etisalat/files/reusable_widgets/buttons/buy_button.dart';
import 'package:etisalat/files/reusable_widgets/buttons/play_button.dart';
import 'package:etisalat/files/reusable_widgets/custom_scroll_view/generic_scroll_view.dart';
import 'package:etisalat/files/reusable_widgets/generic_grid_view.dart';
import 'package:etisalat/files/reusable_widgets/get_navigation_view.dart';
import 'package:etisalat/files/reusable_widgets/loading_indicator.dart';
import 'package:etisalat/files/reusable_widgets/tune_card.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MusicBoxContentScreen extends StatelessWidget {
  MusicBoxContentScreen(
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
          sliverAppBar: getNavigationView(musicBoxStr,
              rightButton: buyButton(
                  isMusicBox: true,
                  TuneInfo(
                      toneId: toneid,
                      toneName: toneName,
                      toneIdpreviewImageUrl: imgUrl),
                  padding: EdgeInsets.symmetric(horizontal: 16))),
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
