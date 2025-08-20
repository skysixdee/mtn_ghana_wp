import 'package:mtn_ghana_wp/files/controllers/music_box_controller.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_scroll_view/generic_scroll_view.dart';

import 'package:mtn_ghana_wp/files/reusable_widgets/get_navigation_view.dart';

import 'package:mtn_ghana_wp/files/reusable_widgets/music_box_card.dart';

import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MusicBoxScreen extends StatelessWidget {
  MusicBoxScreen({super.key});
  final MusicBoxController con = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return GenericScrollView(
          sliverAppBar: getNavigationView(musicBoxStr),
          isLoading: con.isLoadingList.value,
          itemCount: con.musicBoxList.length,
          builder: (p0) {
            return MusicBoxCard(
              info: con.musicBoxList[p0],
              index: p0,
            );
          },
        );
      },
    );
  }
}
