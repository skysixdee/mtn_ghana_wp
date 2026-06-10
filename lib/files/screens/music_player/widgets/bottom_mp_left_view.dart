import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_image.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:mtn_ghana_wp/main.dart';

import 'package:responsive_builder/responsive_builder.dart';

class BottomMpLeftView extends StatelessWidget {
  const BottomMpLeftView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: 1,
                child: customImage(
                  cornerRadius: 8,
                  url: pCont.toneinfo.value.toneIdpreviewImageUrl ?? "",
                ),
              ),
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: pCont.toneinfo.value.toneName,
                    color: white,
                    fontName: FontName.semiBold,
                    fontSize: 12,
                  ),
                  CustomText(
                    title: pCont.toneinfo.value.artistName,
                    color: offWhite,
                    fontName: FontName.regular,
                    fontSize: 10,
                  )
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsetsGeometry.directional(start: 20.0),
                child: Obx(
                  () {
                    return GenericButton(
                      textColor: white,
                      textColorD: blackD,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      title: buyStr,
                      fontName: si.isMobile ? FontName.regular : FontName.bold,
                      leadingIcon: Icon(
                        Icons.card_travel,
                        size: 16,
                        color: appCont.isDarkTheme.value ? blackD : white,
                      ),
                      bgColor: appCont.isDarkTheme.value ? offWhite : black,
                      onTap: () {
                        print(
                            "tapped song is ${pCont.toneinfo.value.toneName}");
                        //buyGiftSmsPopu(toneInfo: pCont.toneinfo.value);
                      },
                    );
                  },
                )),
          ],
        );
      },
    );
  }
}
