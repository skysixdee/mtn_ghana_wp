import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_image.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/screens/mood_detect/moods_controller.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:mtn_ghana_wp/main.dart';

import 'package:responsive_builder/responsive_builder.dart';

class MoodListView extends StatelessWidget {
  MoodListView({super.key, this.physics});
  final ScrollPhysics? physics;
  final MoodsController con = Get.find();
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: "${con.mood.value.toUpperCase()} $tunesStr",
              fontName: si.isMobile ? FontName.semiBold : FontName.bold,
              fontSize: si.isMobile ? 16 : 20,
            ),
            physics == null ? Flexible(child: listView()) : listView(),
          ],
        );
      },
    );
  }

  ListView listView() {
    return ListView.builder(
      physics: physics,
      itemCount: con.moodList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var item = con.moodList[index];
        return Padding(
          padding:
              const EdgeInsets.only(bottom: 10.0, top: 2, left: 2, right: 2),
          child: InkWell(
            onTap: () {
              // pCont.toneinfo.value = con.moodList[index];
              // pCont.tuneList.value = con.moodList;
              // pCont.playUrl(con.moodList[index]);
            },
            child: Obx(
              () {
                return Container(
                  decoration: BoxDecoration(
                    color: appCont.isDarkTheme.value ? blackD : white,
                    boxShadow: [
                      BoxShadow(
                          color: appCont.isDarkTheme.value
                              ? white.withValues(alpha: 0.1)
                              : black.withValues(alpha: 0.1),
                          spreadRadius: 1,
                          blurRadius: 2)
                    ],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Stack(
                          children: [
                            customImage(
                                cornerRadius: 4,
                                url: item.toneIdpreviewImageUrl),
                            // MpPlayButton(
                            //     padding: EdgeInsets.zero,
                            //     width: 40,
                            //     radius: 2,
                            //     bgColor: (pCont.playingUrl.value ==
                            //             item.toneIdStreamingUrl)
                            //         ? red
                            //         : black.withValues(alpha: 0.4),
                            //     tuneList: con.moodList,
                            //     playColor: white,
                            //     tuneInfo: con.moodList[index])
                          ],
                        ),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              title: item.toneName,
                              fontName: FontName.bold,
                              fontSize: 12,
                            ),
                            CustomText(
                              title: item.artistName,
                              fontSize: 12,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
