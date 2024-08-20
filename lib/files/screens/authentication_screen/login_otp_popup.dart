import 'package:etisalat/files/controllers/auth_controller/login_controller.dart';
import 'package:etisalat/files/controllers/auth_controller/otp_controller.dart';
import 'package:etisalat/files/enums/fonts.dart';
import 'package:etisalat/files/reusable_widgets/buttons/generic_button.dart';
import 'package:etisalat/files/reusable_widgets/custom_search_textfield.dart';
import 'package:etisalat/files/reusable_widgets/print_custom.dart';
import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/reusable_widgets/loading_indicator.dart';

import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginOtpPopup extends StatefulWidget {
  const LoginOtpPopup({super.key});

  @override
  State<LoginOtpPopup> createState() => _LoginOtpPopupState();
}

class _LoginOtpPopupState extends State<LoginOtpPopup> {
  TextEditingController textEditingController = TextEditingController();
  LoginController loginController = Get.find();
  late OtpController otpController;
  @override
  void initState() {
    Get.lazyPut(() => OtpController());
    otpController = Get.find();
    otpController.onResentButtonAction(
        second: loginController.expireTime, isLoading: false);
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<OtpController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  closeButton(context),
                  const SizedBox(height: 30),
                  message(),
                  const SizedBox(height: 20),
                  otpTextField(),
                  errorMessage(),
                  const SizedBox(height: 20),
                  verifyOptButton(),
                  const SizedBox(height: 4),
                  resendButton(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  CustomText message() {
    return CustomText(
      title: "$otpHasBeenSendStr\n ${loginController.msisdn}",
      textAlign: TextAlign.center,
    );
  }

  Widget verifyOptButton() {
    return Obx(
      () {
        return otpController.isLoading.value
            ? loadingIndicator(width: 200)
            : GenericButton(
                width: 200,
                bgColor:
                    otpController.enableVerifyButton.value ? yellow : lightGrey,
                title: verifyOtpStr,
                onTap: () {
                  otpController.onVerifyButtonAction();
                  customPrint("generate otp");
                },
              );
      },
    );
  }

  Widget errorMessage() {
    return Obx(
      () {
        return Visibility(
            visible: otpController.message.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: CustomText(
                title: otpController.message.value,
                color: red,
                fontSize: 12,
                fontName: FontName.regular,
              ),
            ));
      },
    );
  }

  Widget resendButton() {
    return Obx(
      () {
        return otpController.isResendingOtp.value
            ? loadingIndicator(width: 200)
            : GenericButton(
                textColor: otpController.enableResend.value ? grey : black,
                bgColor: transparent,
                width: 200,
                leadingIcon: CustomText(
                  title: resendStr,
                  fontName: FontName.bold,
                  color: otpController.enableResend.value ? black : grey,
                ),
                title: otpController.leftTime.value,
                onTap: () {
                  otpController.onResentButtonAction(
                      second: loginController.expireTime);
                },
              );
      },
    );
  }

  Obx otpTextField() {
    return Obx(
      () {
        return CustomSearchTextfield(
          isNumericTextField: true,
          enabled: !otpController.isLoading.value,
          leadingChild: const SizedBox(width: 50),
          trailingChild: GenericButton(
            onTap: () {
              otpController.secureOtp.value = !otpController.secureOtp.value;
            },
            bgColor: transparent,
            padding: const EdgeInsets.only(left: 6, right: 8),
            leadingIcon: Icon(otpController.secureOtp.value
                ? Icons.visibility
                : Icons.visibility_off),
          ), // ,
          obscureText: otpController.secureOtp.value,
          width: 340,
          hintText: enterOtpStr,
          controller: textEditingController,
          maxLength: otpLength,
          textAlign: TextAlign.center,
          onChange: (p0) {
            otpController.onChangeOtp(p0);
          },
          onSubmit: (p0) {
            otpController.onVerifyButtonAction();
          },
        );
      },
    );
  }

  Widget closeButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 8, top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            title: enterSixDigitOtpStr,
            fontName: FontName.bold,
            fontSize: 16,
          ),
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
    );
  }
}
