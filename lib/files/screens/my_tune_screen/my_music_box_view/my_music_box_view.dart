import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/custom_scroll_view/align_grid_combine_view.dart';
import 'package:etisalat/files/reusable_widgets/custom_scroll_view/combined_grid.dart';
import 'package:etisalat/files/reusable_widgets/custom_scroll_view/generic_scroll_view.dart';
import 'package:etisalat/files/reusable_widgets/print_custom.dart';
import 'package:etisalat/files/reusable_widgets/generic_grid_view.dart';
import 'package:etisalat/files/reusable_widgets/loading_indicator.dart';
import 'package:etisalat/files/reusable_widgets/music_box_card.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:etisalat/files/controllers/my_tune_controllers/my_music_box_controller.dart';

class MyMusicBoxView extends StatelessWidget {
  MyMusicBoxView({super.key});
  final MyMusicBoxController con = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return CombinedGrid(
            isLoading: con.isLoading.value,
            itemCount: con.tuneList.length,
            cardWidth: 220,
            padding: null,
            builder: (p0) {
              return MusicBoxCard(
                info: con.tuneList[p0],
                rightButton: deleteButton(),
              );
            },
            onTap: (p1) => {});
        // GenericScrollView(
        //   isLoading: con.isLoading.value,
        //   itemCount: con.tuneList.length,
        //   builder: (p0) {
        //     return MusicBoxCard(
        //       info: con.tuneList[p0],
        //       rightButton: deleteButton(),
        //     );
        //   },
        // );
      },
    );
  }

  Widget deleteButton() {
    return GenericButton(
      title: deleteStr,
      leadingIcon: const Icon(Icons.delete, size: 18, color: red),
      borderColor: red,
      textColor: red,
      bgColor: transparent,
      onTap: () {
        customPrint("delete Music box ");
      },
    );
  }
}
