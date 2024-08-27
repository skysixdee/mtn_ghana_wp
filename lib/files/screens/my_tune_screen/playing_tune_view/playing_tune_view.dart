import 'package:etisalat/files/controllers/my_tune_controllers/my_playing_tune_controller.dart';
import 'package:etisalat/files/reusable_widgets/custom_scroll_view/align_grid_combine_view.dart';
import 'package:etisalat/files/reusable_widgets/custom_scroll_view/aligned_grid.dart';
import 'package:etisalat/files/reusable_widgets/custom_scroll_view/combined_grid.dart';
import 'package:etisalat/files/reusable_widgets/custom_scroll_view/generic_scroll_view.dart';
import 'package:etisalat/files/reusable_widgets/custom_scroll_view/tune_grid_view.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/reusable_widgets/generic_grid_view.dart';
import 'package:etisalat/files/reusable_widgets/loading_indicator.dart';
import 'package:etisalat/files/screens/my_tune_screen/playing_tune_view/widgets/playing_tune_card.dart';
import 'package:etisalat/files/utility/colors.dart';
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
