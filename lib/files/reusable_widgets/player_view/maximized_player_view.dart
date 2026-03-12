import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:glossy/glossy.dart';
import 'package:mtn_ghana_wp/files/controllers/new_player_controller.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/player_view/max_widgets/max_left_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/player_view/max_widgets/max_right_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/player_view/maximized_mobile_view.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';

import 'package:responsive_builder/responsive_builder.dart';

class MaximizedPlayerView extends StatelessWidget {
  MaximizedPlayerView({super.key});
  final PlayerController playerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return si.isMobile
            ? MaximizedMobileView()
            : Stack(
                children: [
                  mainList(context),
                  closeButton(),
                ],
              );
      },
    );
    // Column(
    //   children: [
    //     //SizedBox(height: webNavViewHeight),
    //     mainContainer(context),
    //   ],
    // );
  }

  // Expanded mainContainer(BuildContext context) {
  //   return Expanded(
  //       child: Stack(
  //     children: [
  //       mainList(context),
  //       closeButton(),
  //     ],
  //   ));
  // }

  Widget closeButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GenericButton(
            padding: const EdgeInsets.all(0),
            width: 34,
            height: 34,
            bgColor: lightGrey,
            radius: 17,
            leadingIcon: const Icon(
              Icons.fullscreen_exit,
              color: black,
              size: 14,
            ),
            onTap: () {
              playerController.maximizePlayer(false);
              //playerController.isPlayerMaxSize.value = false;
            },
          )
        ],
      ),
    );
  }

  Widget mainList(BuildContext context) {
    return Container(
      color: grey.withValues(alpha: 0.85),
      width: double.infinity,
      child: GlossyContainer(
        strengthX: 6.0,
        strengthY: 6.0,
        height: double.maxFinite,
        width: double.maxFinite,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MediaQuery.of(context).size.width < 1100
                    ? Flexible(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: fixedWidgth(width: 1090),
                        ),
                      )
                    : Flexible(child: fixedWidgth()),
              ],
            );
          },
        ),
      ),
    );
  }

  SizedBox fixedWidgth({double? width}) {
    return SizedBox(
      width: width ?? 1200,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: MaxLeftView()),
                  Flexible(child: SizedBox(width: 300, child: MaxRightView()))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
