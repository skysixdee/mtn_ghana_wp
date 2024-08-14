import 'dart:async';

import 'package:etisalat/files/utility/constants.dart';
import 'package:etisalat/files/utility/strings.dart';
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

  @override
  void onInit() {
    super.onInit();
    //onResentButtonAction();
    print("OtpController onInit");
  }

  onVerifyButtonAction() async {
    if (otp.isEmpty || otp.length < otpLength) {
      message.value = enterOtpStr;

      return;
    }
    print("qwrweter");

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;
  }

  onChangeOtp(String value) {
    message.value = '';
    otp = value;
    enableVerifyButton.value = value.length >= otpLength;
  }

  onResentButtonAction({int second = 0, bool isLoading = true}) async {
    if (!enableResend.value) {
      return;
    }

    if (isLoading) {
      isResendingOtp.value = true;
      enableResend.value = true;
      await Future.delayed(Duration(seconds: 3));
      isResendingOtp.value = false;
    }
    enableResend.value = false;
    _start = second;
    leftTime.value = " ${formattedTime(timeInSecond: _start)}"; //"$_start";

    print("object sky");
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
