import 'package:mtn_ghana_wp/files/controllers/music_box_controller.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_scroll_view/generic_scroll_view.dart';

import 'package:mtn_ghana_wp/files/reusable_widgets/get_navigation_view.dart';

import 'package:mtn_ghana_wp/files/reusable_widgets/music_box_card.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';

import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MusicBoxScreen extends StatelessWidget {
  MusicBoxScreen({super.key});
  final MusicBoxController con = Get.find();
  RxInt selectedTab = 0.obs;
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        //return oldMusicBox(si);
        return newMusicBox(si);
      },
    );
  }

  Widget oldMusicBox(SizingInformation si) {
    return GenericScrollView(
      physics: const NeverScrollableScrollPhysics(),
      onlyGrid: si.isMobile,
      //sliverAppBar: getNavigationView(musicBoxStr),
      sliverToBoxAdapter: getNavigationView(musicBoxStr),
      isLoading: con.isLoadingList.value,
      itemCount: con.musicBoxList.length,
      builder: (p0) {
        return MusicBoxCard(
          info: con.musicBoxList[p0],
          index: p0,
        );
      },
    );
  }

  Widget newMusicBox(SizingInformation si) {
    return Column(
      children: [
        getNavigationView(musicBoxStr),
        const SizedBox(height: 4),
        musicBoxTab(si),
        Expanded(child: musicBoxTabContent(si)),
      ],
    );
  }

  Widget musicBoxTab(SizingInformation si) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: si.isMobile ? 15 : 50),
        child: Obx(
          () => Row(
            spacing: si.isMobile ? 10 : 20,
            children: [
              Expanded(
                  child: GenericButton(
                radius: 4,
                fontSize: si.isMobile ? 13 : 14,
                bgColor: selectedTab.value == 0 ? yellow : white,
                title: goldStr,
                borderColor: selectedTab.value == 0 ? transparent : grey,
                onTap: () {
                  selectedTab.value = 0;
                  con.getGoldMusicBoxContent();
                },
              )),
              Expanded(
                  child: GenericButton(
                title: silverStr,
                radius: 4,
                fontSize: si.isMobile ? 13 : 14,
                borderColor: selectedTab.value == 1 ? transparent : grey,
                bgColor: selectedTab.value == 1 ? yellow : white,
                onTap: () {
                  selectedTab.value = 1;
                  con.getSilverMusicBoxContent();
                },
              )),
              Expanded(
                  child: GenericButton(
                title: bronzeStr,
                radius: 4,
                fontSize: si.isMobile ? 13 : 14,
                borderColor: selectedTab.value == 2 ? transparent : grey,
                bgColor: selectedTab.value == 2 ? yellow : white,
                onTap: () {
                  selectedTab.value = 2;
                  con.getBronzeMusicBoxContent();
                },
              )),
            ],
          ),
        ));
  }

  Widget musicBoxTabContent(SizingInformation si) {
    return Obx(
      () => AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          // Custom transition combining Fade + Slide
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 4),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          // Key is REQUIRED so AnimatedSwitcher knows when the tab changes
          child: Skeletonizer(
            enabled: con.isLoadingContent.value,
            child: GenericScrollView(
              key: ValueKey<int>(selectedTab.value),
              physics: const NeverScrollableScrollPhysics(),
              onlyGrid: si.isMobile,
              //isLoading: con.isLoadingList.value,
              itemCount: selectedTab.value == 0
                  ? con.goldMusicBoxContentList.length
                  : (selectedTab.value == 1
                      ? con.silverMusicBoxContentList.length
                      : con.bronzeMusicBoxContentList.length),
              builder: (p0) {
                return MusicBoxCard(
                  info: con.musicBoxList[p0],
                  index: p0,
                );
              },
            ),
          )),
    );
  }
}
