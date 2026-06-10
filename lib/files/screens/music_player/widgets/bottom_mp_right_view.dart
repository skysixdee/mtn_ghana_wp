import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/main.dart';

import 'package:responsive_builder/responsive_builder.dart';

class BottomMpRightView extends StatelessWidget {
  const BottomMpRightView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Obx(() {
          final isFullScreen = pCont.isMusicPlayerFullScreen.value;

          return Row(
            spacing: 4,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!si.isMobile) musicQueue(),
              if (!si.isMobile && !isFullScreen) menuButton(),
              expandButton(),
              closeButton(),
            ],
          );
        });
      },
    );
  }

  Widget menuButton() {
    return GenericButton(
      fontName: FontName.semiBold,
      fontSize: 12,
      bgColor: transparent,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      width: 40,
      leadingIcon: Icon(
        Icons.more_horiz,
        color: white,
        size: 18,
      ),
      onTap: () {
        print("tapped menu button");
      },
    );
  }

  Widget closeButton() {
    return GenericButton(
      fontName: FontName.semiBold,
      fontSize: 12,
      bgColor: transparent,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      width: 40,
      leadingIcon: const Icon(
        Icons.close,
        color: white,
        size: 18,
      ),
      onTap: () {
        print("tapped close button");
        pCont.isMusicPlayerOpen.value = false;
        pCont.stopAudio();
      },
    );
  }

  Widget expandButton() {
    return Obx(
      () {
        return GenericButton(
          width: 40,
          fontName: FontName.semiBold,
          fontSize: 12,
          bgColor: transparent,
          padding: const EdgeInsets.symmetric(horizontal: 0),
          leadingIcon: Icon(
            pCont.isMusicPlayerFullScreen.value
                ? Icons.fullscreen_exit
                : Icons.fullscreen,
            color: white,
            size: 18,
          ),
          onTap: () {
            pCont.isMusicPlayerFullScreen.value =
                !pCont.isMusicPlayerFullScreen.value;
            print("tapped menu button");
          },
        );
      },
    );
  }

  GenericButton musicQueue() {
    return GenericButton(
      fontName: FontName.semiBold,
      fontSize: 12,
      bgColor: transparent,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      leadingIcon: const Padding(
        padding: EdgeInsetsGeometry.directional(end: 4.0),
        child: Icon(
          Icons.queue_music,
          color: white,
          size: 18,
        ),
      ),
      title: "${pCont.currentIndex.value + 1}/${pCont.tuneList.length}",
      textColor: white,
    );
  }
}
