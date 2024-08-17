import 'package:etisalat/files/controllers/music_box_controller.dart';
import 'package:etisalat/files/reusable_widgets/generic_grid_view.dart';
import 'package:etisalat/files/reusable_widgets/loading_indicator.dart';
import 'package:etisalat/files/reusable_widgets/tune_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MusicBoxScreen extends StatelessWidget {
  MusicBoxScreen({super.key});
  final MusicBoxController con = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return con.isLoadingList.value
            ? loadingIndicator()
            : GenericGridView(
                itemCount: con.musicBoxList.length,
                builder: (p0) {
                  return TuneCard(info: con.musicBoxList[p0]);
                },
              );
      },
    );
  }
}
