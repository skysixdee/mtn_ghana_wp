import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/url_launcher.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WebFooterView extends StatelessWidget {
  const WebFooterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Container(
          color: black,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: si.isMobile ? 12 : 25, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [privacyPolicyButton()]),
                Row(children: [termsAndConditionButton()]),
                const SizedBox(height: 8),
                Container(height: 1, color: white),
                const SizedBox(height: 8),
                CustomText(
                  title: copyrightStr,
                  color: white,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  GenericButton privacyPolicyButton() {
    return GenericButton(
      height: 22,
      padding: EdgeInsets.zero,
      fontName: FontName.regular,
      bgColor: transparent,
      title: privacyPolicyStr,
      textColor: white,
      onTap: () {
        customLaunchUrl(privacyPolicyUrl);
      },
    );
  }

  GenericButton termsAndConditionButton() {
    return GenericButton(
      padding: EdgeInsets.zero,
      height: 22,
      fontName: FontName.regular,
      bgColor: transparent,
      title: termsAndConditions,
      textColor: white,
      onTap: () {
        customLaunchUrl(termsAndConditionUrl);
      },
    );
  }
}
