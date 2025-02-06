import 'dart:async';

import 'package:mtn_ghana_wp/files/api_calls/authorization/confirm_otp_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/authorization/generate_otp_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/authorization/password_validation_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/authorization/security_token_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_search_tune_list_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/set_tone_api.dart';
import 'package:mtn_ghana_wp/files/model/confirm_otp_model.dart';
import 'package:mtn_ghana_wp/files/model/generic_model.dart';
import 'package:mtn_ghana_wp/files/model/password_validation_model.dart';
import 'package:mtn_ghana_wp/files/model/security_token_model.dart';
import 'package:mtn_ghana_wp/files/model/subscriber_validation_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_alert_popup.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/print_custom.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  RxBool secureOtp = true.obs;
  RxString message = ''.obs;
  String otp = '';
  RxBool isLoading = false.obs;
  RxBool isResendingOtp = false.obs;
  RxBool enableResend = true.obs;
  RxString leftTime = ''.obs;
  RxBool enableVerifyButton = false.obs;

  late Timer _timer;
  int _start = 0;
  TuneInfo? info;
  Function()? onSuccess;
  @override
  void onInit() {
    super.onInit();
    otp = '';
    customPrint("OtpController onInit");
  }

  onVerifyButtonAction(String msisdn) async {
    if (otp.isEmpty || otp.length < otpLength) {
      message.value = enterOtpStr;

      return;
    }
    customPrint("qwrweter");

    isLoading.value = true;

    ConfirmOtpModel confirmOtpModel = await confirmOtpApi(msisdn, otp);
    if (confirmOtpModel.statusCode == 'SC0000') {
      getSecurityToken(msisdn);
    } else {
      message.value = confirmOtpModel.message;
      isLoading.value = false;
    }
  }

  getSecurityToken(String msisdn) async {
    SecurityTokenModel securityTokenModel = await getSecurityTokenApi();
    if (securityTokenModel.statusCode == 'SC0000') {
      passwordValidation(
          msisdn, securityTokenModel.responseMap?.securityCounter ?? '');
    } else {
      message.value = someThingWentWrongStr;
      isLoading.value = false;
    }
  }

  passwordValidation(String msisdn, String securityCounter) async {
    PasswordValidationModel passwordValidationModel =
        await passwordValidationApi(msisdn, securityCounter);
    if (passwordValidationModel.statusCode == 'SC0000') {
      if (info != null) {
        buyTune();
      } else {
        if (onSuccess != null) {
          onSuccess!();
        }
      }
    } else {
      message.value = someThingWentWrongStr;
      isLoading.value = false;
    }
  }

  buyTune() async {
    GenericModel model =
        await setToneApi(info?.toneId ?? '', info?.toneName ?? '');
    if (model.statusCode == "SC0000") {
      openAlertPopup(
        message: model.message ?? '',
        onPrimary: () {
          if (onSuccess != null) {
            onSuccess!();
          }
        },
      );
    } else {
      message.value = model.message ?? someThingWentWrongStr;
    }
    isLoading.value = false;
  }

  onChangeOtp(String value) {
    message.value = '';
    otp = value;
    enableVerifyButton.value = value.length >= otpLength;
  }

  onResentButtonAction(String msisdn,
      {int second = 0, bool isLoading = true}) async {
    if (!enableResend.value) {
      return;
    }

    if (isLoading) {
      isResendingOtp.value = true;
      enableResend.value = true;
      SubscriberValidationModel model = await generateOtpApi(msisdn);
      if (model.statusCode == 'SC0000') {
      } else {
        message.value = model.message ?? someThingWentWrongStr;
      }
      //await Future.delayed(Duration(seconds: 3));
      //confirmOtpApi();
      isResendingOtp.value = false;
    }
    enableResend.value = false;
    _start =otpTimeLimit; //second;
    leftTime.value = " ${formattedTime(timeInSecond: _start)}"; //"$_start";

    customPrint("object sky");
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0 || _start == 1) {
          timer.cancel();
          leftTime.value = "";
          enableResend.value = true;
        } else {
          _start--;
          enableResend.value = false;
          leftTime.value =
              " ${formattedTime(timeInSecond: _start)}"; //"$_start";
        }
      },
    );
  }

  formattedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }
}
