import 'package:etisalat/files/utility/constants.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxString message = ''.obs;
  String msisdn = '';
  RxBool enableButton = false.obs;
  RxBool isLoading = false.obs;
  RxBool displayOptScreen = false.obs;
  int expireTime = 5;
  @override
  void onInit() {
    super.onInit();
    print("LoginController  onInit");
  }

  onGenerateOtpButtonAction() async {
    if (msisdn.isEmpty || msisdn.length < msisdnLength) {
      message.value = enterMobileNumberStr;
      print("object");
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    displayOptScreen.value = true;
    isLoading.value = false;
  }

  onChangeMsidn(String value) {
    message.value = '';
    msisdn = value;
    enableButton.value = value.length >= msisdnLength;
  }
}
