import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomBannerView extends StatelessWidget {
  const BottomBannerView({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4),
      child: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          return Container(
            color: black,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textButton(privacyPolicyStr, () {}),
                  textButton(termsAndConditions, () {}),
                  const SizedBox(height: 16),
                  Container(height: 1, color: white),
                  const SizedBox(height: 8),
                  CustomText(
                    textAlign: TextAlign.left,
                    title: copyrightStr,
                    color: white,
                    fontSize: 10,
                  )
                ],
              ),
            ),
          );
          // if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
          //   return _buildMobileFooter();
          // } else {
          //   return _buildDesktopFooter();
          // }
        },
      ),
    );
  }

  Row textButton(String title, Function()? onTap) {
    return Row(
      children: [
        GenericButton(
          height: 20,
          title: title,
          fontName: FontName.regular,
          textColor: white,
          bgColor: transparent,
          padding: EdgeInsets.zero,
          onTap: onTap,
        ),
      ],
    );
  }
}
