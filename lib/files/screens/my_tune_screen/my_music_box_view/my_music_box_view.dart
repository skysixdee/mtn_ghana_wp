import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';

import 'package:mtn_ghana_wp/files/reusable_widgets/custom_scroll_view/combined_grid.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/print_custom.dart';

import 'package:mtn_ghana_wp/files/reusable_widgets/music_box_card.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mtn_ghana_wp/files/controllers/my_tune_controllers/my_music_box_controller.dart';

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
                isMyMusicBox: true,
                info: con.tuneList[p0],
                leftButton: previewButton(context, con.tuneList[p0]),
                rightButton: deleteButton(con.tuneList[p0]),
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
