import 'package:etisalat/files/controllers/music_box_controller.dart';
import 'package:etisalat/files/enums/custpm_screen_type.dart';
import 'package:etisalat/files/reusable_widgets/buttons/play_button.dart';
import 'package:etisalat/files/reusable_widgets/custom_scroll_view/generic_scroll_view.dart';
import 'package:etisalat/files/reusable_widgets/generic_grid_view.dart';
import 'package:etisalat/files/reusable_widgets/loading_indicator.dart';
import 'package:etisalat/files/reusable_widgets/tune_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MusicBoxContentScreen extends StatelessWidget {
  MusicBoxContentScreen({super.key});
  final MusicBoxController con = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return GenericScrollView(
          isLoading: con.isLoadingContent.value,
          itemCount: con.musicBoxContentList.length,
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
