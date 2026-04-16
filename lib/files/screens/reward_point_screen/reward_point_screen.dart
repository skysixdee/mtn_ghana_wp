import 'dart:math';

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
import 'package:mtn_ghana_wp/files/reusable_widgets/empty_list_widget.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/loading_indicator.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/navigation_header_view.dart';

import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/images.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:mtn_ghana_wp/main.dart';
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

  final double height = 250;
  @override
  void dispose() {
    Get.delete<RewardPointController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Column(
          children: [
            NavigationHeaderView(titleList: [
              NavigationHeaderModel(homeStr, homeRoute),
              NavigationHeaderModel(rewardPointStr, rewardPointRoute),
            ]),
            if (!sizingInformation.isMobile)
              ResponsiveBuilder(
                builder: (context, si) {
                  return Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      CustomScreenHeaderView(
                        descFontSize: si.isMobile ? 12 : 14,
                        titleFontSize: si.isMobile ? 14 : 16,
                        height: height,
                        imageName: nameTuneHeaderPng,
                        title: rewarPointOvalTitleStr,
                        subTitle: rewarPointOvalSubTitleStr,
                      ),
                      if (!si.isMobile)
                        leaderBoadrdWidget(
                            context, si.isMobile ? (height + 50) : height)
                    ],
                  );
                },
              ),
            //leaderBoadrdWidget(120, isHorizontal: true),
            if (sizingInformation.isMobile)
              leaderBoadrdWidget(
                  context, sizingInformation.isMobile ? (height + 50) : height),
            Expanded(
              child: Obx(
                () {
                  return appCont.isLoggedIn.value
                      ? Center(
                          child: ListView(
                            shrinkWrap: true,
                            children: [rewardDescriptionWidget(context)],
                          ),
                        )
                      : ListView(
                          shrinkWrap: true,
                          children: [
                            emptyListWidget(
                                message: loginToCheckYourStr.replaceAll(
                                    "FEATURE_NAME",
                                    rewardPointStr.toUpperCase()),
                                height: 300)
                          ],
                        );
                },
              ),
            )
          ],
        );
      },
    );
  }

  Widget rewardDescriptionWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
    );
  }

  Widget userHasRewardPoints(BuildContext context, String rewardPoint) {
    double mSize = 13;
    double tSize = 15;
    return ResponsiveBuilder(
      builder: (context, si) {
        return Column(
          spacing: 6,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              fontSize: si.isMobile ? mSize : tSize,
              textAlign: TextAlign.center,
              title: "Great going! You're already earning points. ",
            ),
            Row(
              spacing: 4,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                    fontSize: si.isMobile ? mSize : tSize,
                    textAlign: TextAlign.center,
                    title: """You have accumulated """),
                CustomText(
                  fontSize: si.isMobile ? mSize : tSize,
                  textAlign: TextAlign.center,
                  fontName: FontName.bold,
                  title: rewardPoint,
                ),
                CustomText(
                    fontSize: si.isMobile ? mSize : tSize,
                    textAlign: TextAlign.center,
                    title: 'points'),
              ],
            ),
            CustomText(
              fontSize: si.isMobile ? mSize : tSize,
              textAlign: TextAlign.center,
              title:
                  'Keep exploring new tunes and stay subscribed to keep earning more points.\nCustomers with the highest accumulated points will receive awesome cash rewards.\nTerms & conditions apply',
            ),
            // Row(
            //   spacing: 4,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     CustomText(
            //         fontSize: si.isMobile ? mSize : tSize,
            //         textAlign: TextAlign.center,
            //         title: 'Top rewarded customers stand a chance to win'),
            //     CustomText(
            //         fontSize: si.isMobile ? mSize : tSize,
            //         textAlign: TextAlign.center,
            //         fontName: FontName.bold,
            //         title: 'attractive prizes.'),
            //   ],
            // ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: GenericButton(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    bgColor: yellow,
                    title: 'Explore Callertunez',
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

  Widget leaderBoadrdWidget(BuildContext context, double heigh,
      {bool isHorizontal = false}) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Padding(
          padding: isHorizontal
              ? const EdgeInsets.only(top: 20.0)
              : const EdgeInsets.all(0.0),
          child: Container(
            height: isHorizontal
                ? null
                : si.isMobile
                    ? null
                    : heigh - 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              color: isHorizontal
                  ? white
                  : isDarkTheme(context)
                      ? yellowD
                      : yellow,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: isHorizontal
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                if (si.isMobile)
                  Column(
                    children: [
                      Container(
                        height: 1,
                        color: white,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 28.0, right: 28.0, bottom: 10, top: 12),
                        child: Column(
                          children: [
                            CustomText(
                              title: rewarPointOvalTitleStr,
                              fontSize: 16,
                              fontName: FontName.semiBold,
                            ),
                            CustomText(
                              title: rewarPointOvalSubTitleStr,
                              fontName: FontName.regular,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      leaderBoardImage3,
                      height: si.isMobile ? 40 : 50,
                    ),
                    CustomText(
                      title: "Leaderboard".toUpperCase(),
                      fontSize: si.isMobile ? 14 : 18,
                      fontName: FontName.bold,
                    ),
                  ],
                ),
                Container(
                  color: isDarkTheme(context) ? yellowD : yellow,
                  width: isHorizontal
                      ? null
                      : si.isMobile
                          ? double.infinity
                          : 260,
                  child: Center(
                    child: SizedBox(
                      height: isHorizontal ? 60 : null,
                      width: isHorizontal
                          ? null
                          : si.isMobile
                              ? 250
                              : 260,
                      child: leaderBoardList(isHorizontal, si),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget leaderBoardList(bool isHorizontal, SizingInformation si) {
    return Obx(
      () {
        return con.isLoadingLeaderBoard.value
            ? loadingIndicator(height: 150)
            : con.leaderBoardList.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SizedBox(
                          height: 150,
                          child: Center(
                            child: CustomText(
                              textAlign: TextAlign.center,
                              title: checkBackSoonStr,
                              fontName: FontName.regular,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 18.0, left: 50),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       CustomText(
                      //         title: 'MSISDN',
                      //         fontName: FontName.bold,
                      //       ),
                      //       CustomText(
                      //         title: rewarPointDetailStr,
                      //         fontName: FontName.bold,
                      //       ),
                      //       CustomText(
                      //         title: rankStr,
                      //         fontName: FontName.bold,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      ListView.builder(
                        padding: EdgeInsets.only(bottom: 20),
                        scrollDirection:
                            isHorizontal ? Axis.horizontal : Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: con.leaderBoardList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 8),
                            child: Container(
                              width: isHorizontal
                                  ? (si.isMobile ? 150 : 200)
                                  : null,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: isHorizontal ? yellow : white,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(si.isMobile
                                            ? (isHorizontal ? 4 : 2)
                                            : 4.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  isHorizontal ? white : yellow,
                                              borderRadius:
                                                  BorderRadius.circular(60)),
                                          child: Padding(
                                            padding: EdgeInsets.all(si.isMobile
                                                ? (isHorizontal ? 6 : 8)
                                                : 6.0),
                                            child: Icon(
                                              Icons.person,
                                              size: si.isMobile
                                                  ? (isHorizontal ? 14 : 16)
                                                  : 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      CustomText(
                                        title:
                                            con.leaderBoardList[index].msisdn ??
                                                '',
                                        fontName: FontName.semiBold,
                                        fontSize: si.isMobile ? 10 : 12,
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      CustomText(
                                        title: rewarPointDetailStr,
                                        fontName: FontName.semiBold,
                                        color: black,
                                        fontSize: si.isMobile ? 10 : 12,
                                      ),
                                      CustomText(
                                        title: con.leaderBoardList[index]
                                                .rewardPoints ??
                                            '',
                                        fontName: FontName.semiBold,
                                        color: green,
                                        fontSize: si.isMobile ? 10 : 12,
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 18.0),
                                    child: Column(
                                      children: [
                                        CustomText(
                                          fontName: FontName.semiBold,
                                          fontSize: si.isMobile ? 10 : 12,
                                          title: rankStr,
                                        ),
                                        CustomText(
                                          fontName: FontName.semiBold,
                                          fontSize: si.isMobile ? 10 : 12,
                                          color: green,
                                          title:
                                              con.leaderBoardList[index].rank ??
                                                  '',
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
      },
    );
  }

  Widget ovalShape(SizingInformation si) {
    double height = si.screenSize.height * 0.20;

    return ClipOval(
      child: Container(
        width: si.isMobile ? height * 1.3 : height * 1.8,
        height: si.isMobile ? (height * 0.9) : height * 1.2,
        color: yellow,
        child: Padding(
          padding: EdgeInsets.only(left: (height * 0.3) + 14, right: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CustomText(
              //   title: "Ranking",
              //   textAlign: TextAlign.center,
              //   fontName: FontName.bold,
              //   fontSize: si.isMobile ? 14 : 16,
              // ),

              CustomText(
                title: "8123812512 : 1",
                fontName: FontName.regular,
                fontSize: si.isMobile ? 14 : 16,
              ),
              CustomText(
                title: "8123812511 : 2",
                fontName: FontName.regular,
                fontSize: si.isMobile ? 14 : 16,
              ),
              // CustomText(
              //   title: "subTitle ",
              //   fontSize: 16,
              // )
            ],
          ),
        ),
      ),
    );
    // Positioned(
    //   right: -(height * 0.4),
    //   child:
    // );
  }

  Widget userHasNoRewardPoints(BuildContext context) {
    double mSize = 13;
    double tSize = 15;
    return ResponsiveBuilder(
      builder: (context, si) {
        return Column(
          spacing: 6,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              fontSize: si.isMobile ? mSize : tSize,
              textAlign: TextAlign.center,
              fontName: FontName.bold,
              title:
                  "You haven’t earned reward points yet—but you can start anytime.",
            ),
            CustomText(
                fontSize: si.isMobile ? mSize : tSize,
                textAlign: TextAlign.center,
                title:
                    'Our Callertunez Rewards Program lets you earn points on every subscription, tune download, and  renewals.'),
            CustomText(
              fontSize: si.isMobile ? mSize : tSize,
              textAlign: TextAlign.center,
              title: 'Just download your favorite tunes and stay subscribed.',
            ),
            CustomText(
              fontSize: si.isMobile ? mSize : tSize,
              textAlign: TextAlign.center,
              title:
                  'Points add up automatically—and more points mean bigger rewards.',
            ),
            CustomText(
              fontSize: si.isMobile ? mSize : tSize,
              textAlign: TextAlign.center,
              title:
                  'Start earning today and become one of our top rewarded customers.',
              fontName: FontName.bold,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     CustomText(
            //       fontSize: si.isMobile ? mSize : tSize,
            //       textAlign: TextAlign.center,
            //       title: 'Earn more points and win',
            //     ),
            //     CustomText(
            //       fontSize: si.isMobile ? mSize : tSize,
            //       textAlign: TextAlign.center,
            //       fontName: FontName.bold,
            //       title: 'attractive prizes',
            //     ),
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: GenericButton(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    bgColor: yellow,
                    title: 'Explore our tune catalog now',
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
