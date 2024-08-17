import 'package:etisalat/files/controllers/music_box_controller.dart';
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
        return con.isLoadingContent.value
            ? loadingIndicator()
            : GenericGridView(
                itemCount: con.musicBoxContentList.length,
                builder: (p0) {
                  return TuneCard(info: con.musicBoxContentList[p0]);
                },
              );
      },
    );
  }
}
