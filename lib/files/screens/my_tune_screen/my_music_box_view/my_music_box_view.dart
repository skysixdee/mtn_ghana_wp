import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_ghana_wp/files/model/popover_menu_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';

import 'package:mtn_ghana_wp/files/reusable_widgets/custom_scroll_view/combined_grid.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/generic_popover.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/print_custom.dart';

import 'package:mtn_ghana_wp/files/reusable_widgets/music_box_card.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mtn_ghana_wp/files/controllers/my_tune_controllers/my_music_box_controller.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
              return Stack(
                alignment: Alignment.topRight,
                children: [
                  MusicBoxCard(
                    isMyMusicBox: true,
                    info: con.tuneList[p0],
                    leftButton: previewButton(context, con.tuneList[p0]),
                    rightButton: deleteButton(con.tuneList[p0]),
                  ),
                  moreButton(con.tuneList[p0]),
                ],
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

  Widget moreButton(TuneInfo info) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ResponsiveBuilder(
          builder: (context, si) {
            return GenericButton(
              padding: const EdgeInsets.all(0),
              borderColor: black,
              bgColor: white,
              leadingIcon: const Icon(
                Icons.more_horiz,
                color: black,
                size: 18,
              ),
              height: 30,
              width: 30,
              onTap: () {
                print("More button");
                genericPopover(
                  width: 160,
                  context,
                  [
                    //PopoverMenuModel(deleteStr),
                    PopoverMenuModel(addToShuffleStr),
                  ],
                  onTap: (p0, index) async {
                    con.addToShuffle(info.toneId ?? '');
                    customPrint("tapped ${p0.title} and index =$index");
                  },
                );
              },
            );
          },
        ));
  }

  Widget previewButton(BuildContext context, TuneInfo info) {
    return GenericButton(
      padding: EdgeInsets.zero,
      bgColor: transparent,
      title: previewStr,
      leadingIcon: const Icon(Icons.visibility),
      onTap: () {
        context.goNamed(myMusicBoxContentRoute, queryParameters: {
          'type': info.type,
          'code': info.toneId,
          'toneName': info.toneName,
          'toneId': info.toneId,
          'imgUrl': info.toneIdpreviewImageUrl,
        });
        print("view all tune in music box");
      },
    );
  }

  Widget deleteButton(TuneInfo info) {
    return Obx(
      () {
        return info.isDeleting.value
            ? const Expanded(
                child: Center(
                    child: CupertinoActivityIndicator(
                radius: 12,
              )))
            : GenericButton(
                title: deleteStr,
                leadingIcon: const Icon(Icons.delete, size: 18, color: red),
                borderColor: red,
                textColor: red,
                bgColor: transparent,
                onTap: () {
                  con.deleteMyMusicBox(info);
                  customPrint("delete Music box ");
                },
              );
      },
    );
  }
}
