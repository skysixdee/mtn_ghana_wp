import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_ghana_wp/files/controllers/app_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/screens/home_screen/widget/home_pop_banner_view/ai_mood_base_badge.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/images.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:mtn_ghana_wp/main.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomePopBannerView extends StatelessWidget {
  HomePopBannerView({super.key});
  AppController con = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Obx(
          () {
            return appCont.isShowHomePopBanner.value
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: white.withValues(alpha: 0.6),
                                spreadRadius: 1,
                                blurRadius: 12)
                          ]),
                          width: 230,
                          child: AiMoodTunesBadge(
                            onTap: () {
                              context.goNamed(moodDetectRoute);
                              appCont.isShowHomePopBanner.value = false;
                            },
                          )),
                    ],
                  )
                : const SizedBox.shrink();
          },
        );
        // Obx(() {
        //   return Padding(
        //     padding: EdgeInsets.only(
        //         left: si.isMobile ? 8.0 : 15,
        //         right: si.isMobile ? 8.0 : 15,
        //         top: appCont.isShowHomePopBanner.value ? 8 : 0,
        //         bottom: appCont.isShowHomePopBanner.value ? 4 : 0),
        //     child: AnimatedContainer(

        //         duration: const Duration(milliseconds: 300),
        //         height: con.isShowHomePopBanner.value ? homePopBannerHeight : 0,
        //         child: SlidingBanner()
        //         ),
        //   );
        // });
      },
    );
  }
}

class SlidingBanner extends StatefulWidget {
  const SlidingBanner({super.key});

  @override
  State<SlidingBanner> createState() => _SlidingBannerState();
}

class _SlidingBannerState extends State<SlidingBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  AppController con = Get.find<AppController>();
  bool isVisible = true; // control banner visibility

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // 👉 START from RIGHT
      end: Offset.zero, // 👉 END at original position
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.forward(); // start animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void closeBanner() async {
    await _controller.reverse(); // slide back to left
    setState(() {
      isVisible = false;
      con.isShowHomePopBanner.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox();

    return SlideTransition(
      position: _animation,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              context.goNamed(moodDetectRoute); // your route
              closeBanner();
            },
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                // Ribbon + Text
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      ribbonIcon, // your ribbon image
                      height: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, right: 8),
                      child: CustomText(
                        isSelectable: false,
                        title: aiMoodPickerStr,
                        color: white,
                        fontName: FontName.semiBold,
                        // style: TextStyle(
                        //   color: Colors.white,
                        //   fontWeight: FontWeight.w600,
                        // ),
                      ),
                    )
                  ],
                ),

                // Close Button
                Positioned(
                  right: 0,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 18,
                      color: Colors.white,
                    ),
                    onPressed: closeBanner,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
