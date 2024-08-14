import 'package:etisalat/files/controllers/home_controllers/feature_controller.dart';
import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/network_manager/network_manager.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/urls.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FeatureTabView extends StatelessWidget {
  FeatureTabView({super.key});
  FeatureController featureController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: featureController.tabList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.only(right: 14, top: 4, bottom: 4),
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
                          title: featureController.tabList[index].name,
                          fontName: featureController.index.value == index
                              ? FontName.bold
                              : FontName.regular,
                          color: featureController.index.value == index
                              ? yellow
                              : black,
                          fontSize: 18,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1.5),
                            color: featureController.index.value == index
                                ? yellow
                                : transparent,
                          ),
                          height: 4,
                        )
                      ],
                    );
                  },
                )),
              ));
        },
      ),
    );
  }
}
