import 'package:etisalat/files/controllers/auth_controller/login_controller.dart';
import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/country_code.dart';
import 'package:etisalat/files/reusable_widgets/custom_search_textfield.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/reusable_widgets/loading_indicator.dart';

import 'package:etisalat/files/screens/authentication_screen/login_otp_popup.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:etisalat/files/utility/images.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPopup extends StatefulWidget {
  const LoginPopup({super.key});
  //final Function() onSuccess;

  @override
  State<LoginPopup> createState() => _LoginPopupState();
}

class _LoginPopupState extends State<LoginPopup> {
  TextEditingController controller = TextEditingController();
  late LoginController cont;

  @override
  void initState() {
    cont = Get.find();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.text = cont.msisdn;
    return Material(
      color: transparent,
      child: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Container(
            width: popupWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: mainColumn(context),
            )),
      )),
    );
  }

  Widget mainColumn(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GenericButton(
              bgColor: transparent,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              trailingIcon: const Icon(
                Icons.close,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
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
                logo(),
                const SizedBox(height: 20),
                title(),
                subTitle(),
                const SizedBox(height: 20),
                textField(),
                errorMessage(),
                const SizedBox(height: 20),
                requestOtpButton(context),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget errorMessage() {
    return Obx(
      () {
        return Visibility(
            visible: cont.message.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: CustomText(
                title: cont.message.value,
                color: red,
                fontSize: 12,
                fontName: FontName.regular,
              ),
            ));
      },
    );
  }

  Widget requestOtpButton(BuildContext context) {
    return Row(
      children: [
        Obx(
          () {
            return cont.isLoading.value
                ? loadingIndicator(width: 150)
                : GenericButton(
                    bgColor: cont.enableButton.value ? yellow : lightGrey,
                    title: requestotpStr,
                    onTap: () {
                      cont.onGenerateOtpButtonAction();
                    },
                  );
          },
        )
      ],
    );
  }

  Widget textField() {
    return Obx(
      () {
        return CustomSearchTextfield(
          trailingChild: const SizedBox(width: 4),
          enabled: !cont.isLoading.value,
          controller: controller,
          hintText: enterMobileNumberStr,
          isNumericTextField: true,
          maxLength: msisdnLength,
          leadingChild: countryCode(),
          onChange: (p0) {
            cont.onChangeMsidn(p0);
          },
          onSubmit: (p0) {
            cont.onGenerateOtpButtonAction();
          },
        );
      },
    );
  }

  CustomText subTitle() {
    return CustomText(
      title: enterNumberToAuthenticateStr,
      color: black,
      fontSize: 12,
      fontName: FontName.light,
    );
  }

  CustomText title() {
    return CustomText(
      title: signInToYourAccountStr,
      fontName: FontName.bold,
      fontSize: 16,
    );
  }

  Flexible logo() {
    return Flexible(
      child: Image.asset(
        logoImage,
        height: 40,
        fit: BoxFit.cover,
      ),
    );
  }
}
