import 'package:mtn_ghana_wp/files/controllers/home_controllers/feature_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FeatureTabView extends StatelessWidget {
  FeatureTabView({super.key});
  FeatureController featureController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border.all(color: isDarkTheme(context) ? whiteD : transparent),
          color: isDarkTheme(context) ? blackD : lightGrey,
          borderRadius: BorderRadius.circular(10)),
      height: 67,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
        scrollDirection: Axis.horizontal,
        itemCount: featureController.tabList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return tabCell(context, index);
        },
      ),
    );
  }

  Padding tabCell(BuildContext context, int index) {
    return Padding(
        padding: const EdgeInsets.only(right: 14, top: 8, bottom: 8),
        child: Obx(() {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                color: featureController.index.value == index
                    ? isDarkTheme(context)
                        ? yellowD
                        : yellow
                    : grey.withOpacity(0.3)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: InkWell(
                onTap: () {
                  featureController.updateTabIndex(index);
                },
                child: IntrinsicWidth(child: Obx(
                  () {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          isSelectable: false,
                          title: featureController.tabList[index].name,
                          fontName: featureController.index.value == index
                              ? FontName.bold
                              : FontName.regular,
                          colorD: featureController.index.value == index
                              ? blackD
                              : whiteD,
                          color: featureController.index.value == index
                              ? black //yellow
                              : darkGrey, // black,
                          fontSize: 20,
                        ),
                        // featureController.index.value == index
                        //     ? Container(
                        //         decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(1.5),
                        //             color: black
                        //             // featureController.index.value == index
                        //             //     ? black//yellow
                        //             //     : grey//transparent,
                        //             ),
                        //         height: 3,
                        //       )
                        //     : const SizedBox()
                      ],
                    );
                  },
                )),
              ),
            ),
          );
        }));
  }
}
