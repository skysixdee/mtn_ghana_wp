import 'package:mtn_ghana_wp/files/controllers/my_tune_controllers/my_playing_tune_controller.dart';

import 'package:mtn_ghana_wp/files/reusable_widgets/custom_scroll_view/combined_grid.dart';
import 'package:mtn_ghana_wp/files/screens/my_tune_screen/playing_tune_view/widgets/playing_tune_card.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayingTuneView extends StatelessWidget {
  PlayingTuneView({super.key});
  final MyPlayingTuneController con = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return CombinedGrid(
            itemCount: con.tuneList.length,
            isLoading: con.isLoading.value,
            cardWidth: 280,
            aspectRatio: 0.6,
            padding: null,
            builder: (p0) {
              return PlayingTuneCard(info: con.tuneList[p0]);
            },
            onTap: (p1) => {});
        // alignGridCombineView(context, con.tuneList.length, 220,
        //     const NeverScrollableScrollPhysics(), (p0) {
        //   return PlayingTuneCard(info: con.tuneList[p0]);
        // }, (p1) => {});
        // return con.isLoading.value
        //     ? loadingIndicator()
        //     : (con.tuneList.length < 8
        //         ? alignedGrid(
        //             context,
        //             con.tuneList.length,
        //             290,
        //             aspectRatio: 0.55,
        //             const NeverScrollableScrollPhysics(), (p0) {
        //             return PlayingTuneCard(info: con.tuneList[p0]);
        //           }, (p1) {})
        //         : tuneGridView(
        //             cardWidth: 290,
        //             aspectRatio: 0.6,
        //             itemCount: con.tuneList.length,
        //             builder: (p0) {
        //               return PlayingTuneCard(info: con.tuneList[p0]);
        //             }));
        // GenericScrollView(
        //     physics: const NeverScrollableScrollPhysics(),
        //     cardWidth: 290,
        //     //childAspectRatio: 0.55,
        //     //cardHeight: 340,
        //     itemCount: con.tuneList.length,
        //     builder: (p0) {
        //       return PlayingTuneCard(info: con.tuneList[p0]);
        //     },
        //   );
      },
    );
  }
}
