import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/custom_alert_popup.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';

class CreateBlacklistScreen extends StatelessWidget {
  const CreateBlacklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      title: "Create blacklist ",
    );
  }

  Widget titleHeader() {
    return Column(
      children: [
        CustomText(
          title: blackListStr,
          fontName: FontName.bold,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              title: howToCreateBlacklistStr,
              fontName: FontName.regular,
              color: grey,
            ),
            const SizedBox(width: 8),
            GenericButton(
              height: 20,
              padding: EdgeInsets.zero,
              title: learnMoreStr,
              trailingIcon: const Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 10,
                  color: yellow,
                ),
              ),
              fontName: FontName.regular,
              bgColor: transparent,
              textColor: yellow,
              onTap: () {
                openAlertPopup(message: blacklistLearnMoreStr);
              },
            ),
          ],
        ),
      ],
    );
  }
}
