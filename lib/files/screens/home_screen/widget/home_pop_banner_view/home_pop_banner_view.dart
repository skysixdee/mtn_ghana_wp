import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_ghana_wp/files/controllers/app_controller.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/images.dart';
import 'package:mtn_ghana_wp/main.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomePopBannerView extends StatelessWidget {
  HomePopBannerView({super.key});
  AppController con = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Obx(() {
          return Padding(
            padding: EdgeInsets.only(
                left: si.isMobile ? 8.0 : 15,
                right: si.isMobile ? 8.0 : 15,
                top: appCont.isShowHomePopBanner.value ? 8 : 0,
                bottom: appCont.isShowHomePopBanner.value ? 4 : 0),
            child: InkWell(
              onTap: () {
                context.goNamed(moodDetectRoute);
                appCont.isShowHomePopBanner.value = false;
              },
              child: AnimatedContainer(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: isDarkTheme(context)
                          ? whiteD
                          : black.withOpacity(0.4),
                      blurRadius: 4,
                      spreadRadius: 0,
                      offset: const Offset(0, 0),
                    )
                  ],
                  borderRadius: BorderRadius.circular(4),
                  color: isDarkTheme(context) ? yellowD : yellow,
                ),
                duration: const Duration(milliseconds: 300),
                height: con.isShowHomePopBanner.value ? homePopBannerHeight : 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.asset(moodEmojiIcon),
                      Expanded(
                        child: CustomText(
                          isSelectable: false,
                          colorD: black,
                          title: "This is a pop banner",
                        ),
                      ),
                      GenericButton(
                        height: 40,
                        width: 40,
                        padding: EdgeInsets.zero,
                        bgColor: transparent,
                        textColorD: black,
                        leadingIcon: Icon(
                          Icons.close,
                          size: 18,
                          //color: isDarkTheme(context) ? whiteD : black,
                        ),
                        onTap: () {
                          con.isShowHomePopBanner.value = false;
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
