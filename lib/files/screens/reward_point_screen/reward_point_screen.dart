import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_ghana_wp/files/controllers/reward_point_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/model/navigation_header_model.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_screen_header_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_scroll_view/generic_scroll_view.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/loading_indicator.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/navigation_header_view.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/images.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:responsive_builder/responsive_builder.dart';

class RewardPointScreen extends StatefulWidget {
  const RewardPointScreen({super.key});

  @override
  State<RewardPointScreen> createState() => _RewardPointScreenState();
}

class _RewardPointScreenState extends State<RewardPointScreen> {
  late RewardPointController con;
  @override
  void initState() {
    Get.lazyPut(() => RewardPointController());
    con = Get.find();
    con.getRewardPoint();
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<RewardPointController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NavigationHeaderView(titleList: [
          NavigationHeaderModel(homeStr, homeRoute),
          NavigationHeaderModel(rewardPointStr, rewardPointRoute),
        ]),
        ResponsiveBuilder(
          builder: (context, si) {
            return CustomScreenHeaderView(
              descFontSize: si.isMobile ? 12 : 14,
              titleFontSize: si.isMobile ? 14 : 16,
              height: 250,
              imageName: nameTuneHeaderPng,
              title: "Your Callertune Just Got More Rewarding",
              subTitle:
                  "Earn reward points on every CRBT subscription, tune download, and  renewals.",
            );
          },
        ),
        Expanded(
          child: Obx(
            () {
              return con.isLoading.value
                  ? loadingIndicator()
                  : ((con.resp.value.rewardPoints ?? 0) <= 0)
                      ? userHasNoRewardPoints(
                          context,
                        )
                      : userHasRewardPoints(
                          context, "${con.resp.value.rewardPoints ?? 0}");
            },
          ),
        ),
      ],
    );
  }

  Widget userHasRewardPoints(BuildContext context, String rewardPoint) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              fontSize: si.isMobile ? 14 : 18,
              textAlign: TextAlign.center,
              title:
                  "Great going! You’re already earning rewards.\nYour rewards balance is ${rewardPoint} points",
            ),
            CustomText(
                fontSize: si.isMobile ? 14 : 18,
                textAlign: TextAlign.center,
                title:
                    'Keep exploring new tunes, stay subscribed, and boost your reward points.'),
            CustomText(
              fontSize: si.isMobile ? 14 : 18,
              textAlign: TextAlign.center,
              title:
                  'The more you engage, the closer you get to exciting rewards.',
            ),
            CustomText(
              fontSize: si.isMobile ? 14 : 18,
              textAlign: TextAlign.center,
              title: 'Do more. Earn more. Win more.',
              fontName: FontName.bold,
            ),
            CustomText(
              fontSize: si.isMobile ? 14 : 18,
              textAlign: TextAlign.center,
              title:
                  'Top rewarded customers stand a chance to win attractive prizes.',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: GenericButton(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    bgColor: yellow,
                    title: 'explorore more',
                    onTap: () {
                      context.goNamed(homeRoute);
                    },
                  ),
                ),
              ],
            )
            //  CustomText(title: 'Top rewarded customers stand a chance to win attractive prizes.',)
          ],
        );
      },
    );
  }

  Widget userHasNoRewardPoints(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              fontSize: si.isMobile ? 14 : 18,
              textAlign: TextAlign.center,
              fontName: FontName.bold,
              title:
                  "You haven’t earned reward points yet—but you can start anytime.",
            ),
            CustomText(
                fontSize: si.isMobile ? 14 : 18,
                textAlign: TextAlign.center,
                title:
                    'Our Callertunez Rewards Program lets you earn points on every subscription, tune download, and  renewals.'),
            CustomText(
              fontSize: si.isMobile ? 14 : 18,
              textAlign: TextAlign.center,
              title: 'Just download your favorite tunes and stay subscribed.',
            ),
            CustomText(
              fontSize: si.isMobile ? 14 : 18,
              textAlign: TextAlign.center,
              title:
                  'Points add up automatically—and more points mean bigger rewards.',
            ),
            CustomText(
              fontSize: si.isMobile ? 14 : 18,
              textAlign: TextAlign.center,
              title:
                  'Start earning today and become one of our top rewarded customers.',
              fontName: FontName.bold,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  fontSize: si.isMobile ? 14 : 18,
                  textAlign: TextAlign.center,
                  title: 'Earn more points and win',
                ),
                CustomText(
                  fontSize: si.isMobile ? 14 : 18,
                  textAlign: TextAlign.center,
                  fontName: FontName.bold,
                  title: 'attractive prizes',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: GenericButton(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    bgColor: yellow,
                    title: 'explorore more',
                    onTap: () {
                      context.goNamed(homeRoute);
                    },
                  ),
                ),
              ],
            )
            //  CustomText(title: 'Top rewarded customers stand a chance to win attractive prizes.',)
          ],
        );
      },
    );
  }
}
