import 'package:mtn_ghana_wp/files/api_calls/authorization/generate_otp_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/authorization/subscriber_validation_api.dart';
import 'package:mtn_ghana_wp/files/model/subscriber_validation_model.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/print_custom.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
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
    customPrint("LoginController  onInit");
  }

  resetValue() {
    message.value = '';
    msisdn = '';
    enableButton.value = false;
    isLoading.value = false;
    displayOptScreen.value = false;
    expireTime = 5;
  }

  onGenerateOtpButtonAction() async {
    if (msisdn.isEmpty || msisdn.length < msisdnLength) {
      message.value = enterMobileNumberStr;
      customPrint("object");
      return;
    }

    isLoading.value = true;
    SubscriberValidationModel model = await susbcriberValidationApi(msisdn);
    if (model.statusCode == 'SC0000') {
      SubscriberValidationModel genModel = await generateOtpApi(msisdn);
      if (genModel.statusCode == 'SC0000') {
        displayOptScreen.value = true;
      } else {
        message.value = model.message ?? someThingWentWrongStr;
      }
      //displayOptScreen.value = true;
    } else {
      message.value = model.message ?? someThingWentWrongStr;
    }

    isLoading.value = false;
  }

  onChangeMsidn(String value) {
    message.value = '';
    msisdn = value;
    enableButton.value = value.length >= msisdnLength;
  }
}
