import 'package:etisalat/files/api_calls/authorization/generate_otp_api.dart';
import 'package:etisalat/files/api_calls/authorization/subscriber_validation_api.dart';
import 'package:etisalat/files/api_calls/set_tone_api.dart';
import 'package:etisalat/files/model/generic_model.dart';
import 'package:etisalat/files/model/subscriber_validation_model.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:get/get.dart';

class BuyTuneController extends GetxController {
  String msisdn = '';
  RxBool isLoading = false.obs;
  RxString message = ''.obs;
  RxBool displayOptScreen = false.obs;

  resetValue() {
    msisdn = '';
    isLoading.value = false;
    message.value = '';
    displayOptScreen.value = false;
  }

  onConfirmButtonAction(TuneInfo info) async {
    displayOptScreen.value = false;
    message.value = '';
    if (StoreManager.isLoggedIn) {
      buyTone(info);
    } else {
      if (msisdn.isEmpty) {
        message.value = pleaseEnterYourMobileNumberStr;
        return;
      }
      if (msisdn.length < msisdnLength) {
        message.value = enterValidMsisdnStr;
      }
      _subscriberValidation(msisdn);
    }
  }

  updateMsisdn(String msisdn) {
    message.value = '';
    this.msisdn = msisdn;
  }

  buyTone(TuneInfo info) async {
    isLoading.value = true;
    GenericModel model =
        await setToneApi(info.toneId ?? '', info.toneName ?? '');
    if (model.statusCode == 'SC0000') {
    } else {
      message.value = model.message ?? someThingWentWrongStr;
    }
    isLoading.value = false;
  }

  _subscriberValidation(String msisdn) async {
    isLoading.value = true;
    SubscriberValidationModel subsModel = await susbcriberValidationApi(msisdn);
    if (subsModel.statusCode == 'SC0000') {
      _generateOtp(msisdn);
    } else {
      message.value = subsModel.message ?? someThingWentWrongStr;
      isLoading.value = false;
    }
  }

  _generateOtp(String msisnd) async {
    SubscriberValidationModel genModel = await generateOtpApi(msisdn);
    if (genModel.statusCode == 'SC0000') {
      print("generateOtpApi $genModel");
      displayOptScreen.value = true;
      message.value = genModel.message ?? someThingWentWrongStr;
    } else {
      message.value = genModel.message ?? someThingWentWrongStr;
    }
    isLoading.value = false;
  }
}
