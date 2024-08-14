import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/country_code.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/reusable_widgets/msisdn_textfield.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:etisalat/files/utility/images.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';

class LoginPopup extends StatefulWidget {
  const LoginPopup({super.key});

  @override
  State<LoginPopup> createState() => _LoginPopupState();
}

class _LoginPopupState extends State<LoginPopup> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      color: black,
      child: Center(
          child: Container(
              width: popupWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: mainColumn(),
              ))),
    );
  }

  Widget mainColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GenericButton(
              bgColor: transparent,
              padding: EdgeInsets.symmetric(horizontal: 8),
              trailingIcon: Icon(
                Icons.close,
              ),
            )
          ],
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Image.asset(
                    logoImage,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                CustomText(
                  title: signInToYourAccountStr,
                  fontName: FontName.bold,
                  fontSize: 16,
                ),
                CustomText(
                  title: enterNumberToAuthenticateStr,
                  color: grey,
                  fontSize: 12,
                  fontName: FontName.regular,
                ),
                MsisdnTextfield(
                  controller: controller,
                  leadingChild: countryCode(),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    GenericButton(
                      title: requestotpStr,
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
