import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/controllers/app_controller.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';

class HomePopBannerView extends StatelessWidget {
  HomePopBannerView({super.key});
  AppController con = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedContainer(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: isDarkTheme(context) ? whiteD : black.withOpacity(0.4),
                blurRadius: 4,
                spreadRadius: 0,
                offset: const Offset(0, 0),
              )
            ],
            borderRadius: BorderRadius.circular(8),
            color: isDarkTheme(context) ? yellowD : yellow,
          ),
          duration: const Duration(milliseconds: 300),
          height: con.isShowHomePopBanner.value ? homePopBannerHeight : 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomText(
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
      );
    });
  }
}
