import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mtn_ghana_wp/files/screens/music_player/widgets/bottom_mp_center_view.dart';
import 'package:mtn_ghana_wp/files/screens/music_player/widgets/bottom_mp_left_view.dart';
import 'package:mtn_ghana_wp/files/screens/music_player/widgets/bottom_mp_right_view.dart';
import 'package:mtn_ghana_wp/files/screens/music_player/widgets/full_screen_mp_view.dart';
import 'package:mtn_ghana_wp/files/screens/music_player/widgets/mp_slider.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/main.dart';

import 'package:responsive_builder/responsive_builder.dart';

class BottomMpView extends StatelessWidget {
  BottomMpView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Material(
          color: appCont.isDarkTheme.value
              ? blackD.withValues(alpha: 0.98)
              : offWhite.withValues(alpha: 0.98),
          child: Obx(
            () {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
//if (!si.isMobile && !appCont.isMusicPlayerFullScreen.value)

                  if (pCont.isMusicPlayerFullScreen.value)
                    const Expanded(child: FullScreenMpView()),
                  //MpSlider(),
                  if (pCont.isPlaying.value)
                    Container(
                      color: yellowD, //const Color.fromARGB(255, 120, 9, 1),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: MpSlider(),
                      ),
                    ),
                  Container(
                    height: bottomMusicPlayerHeight,
                    color: yellowD, //const Color.fromARGB(255, 120, 9, 1),
                    child: InkWell(
                      onTap: () {
                        pCont.isMusicPlayerFullScreen.value =
                            !pCont.isMusicPlayerFullScreen.value;
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Flexible(child: const BottomMpLeftView()),
                            if (!si.isMobile &&
                                !pCont.isMusicPlayerFullScreen.value)
                              const BottomMpCenterView(),
                            const BottomMpRightView(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
