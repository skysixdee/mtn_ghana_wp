import 'package:mtn_ghana_wp/files/api_calls/authorization/generate_otp_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/authorization/subscriber_validation_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/buy_music_channel_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_pack_detail_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/set_tone_api.dart';
import 'package:mtn_ghana_wp/files/google_tag_manager/google_tag_manager.dart';
import 'package:mtn_ghana_wp/files/model/buy_tone_model.dart';
import 'package:mtn_ghana_wp/files/model/generate_otp_sc_model.dart';
import 'package:mtn_ghana_wp/files/model/generic_model.dart';
import 'package:mtn_ghana_wp/files/model/pack_detail_model.dart';
import 'package:mtn_ghana_wp/files/model/subscriber_validation_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_alert_popup.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:get/get.dart';

class BuyTuneController extends GetxController {
  String msisdn = '';
  RxBool isLoading = false.obs;
  RxString message = ''.obs;
  bool isNewUser = false;
  RxBool displayOptScreen = false.obs;
  Function()? onSuccess;
  String securityToken = "";
  bool isMusicBox = false;
  resetValue() {
    msisdn = '';
    isLoading.value = false;
    message.value = '';
    displayOptScreen.value = false;
  }

  onConfirmButtonAction(TuneInfo info, {bool isMusicBox = false}) async {
    displayOptScreen.value = false;
    this.isMusicBox = isMusicBox;
    message.value = '';
    if (StoreManager.isLoggedIn) {
      if (isMusicBox) {
        buyMusicBox(info);
      } else {
        buyTone(info);
      }
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
    BuyToneModel model =
        await setToneApi(info.toneId ?? '', info.toneName ?? '');
    if (model.respCode == 0) {
      openAlertPopup(
        message: model.message ?? '',
        onPrimary: () {
          if (onSuccess != null) {
            onSuccess!();
          }
        },
      );
      buySuccessfulEvent(
          TuneInfo(toneId: info.toneId, toneName: info.toneName));
      purchaseEvent(TuneInfo(toneId: info.toneId, toneName: info.toneName));
    } else {
      message.value = model.message ?? someThingWentWrongStr;
    }
    isLoading.value = false;
  }

  // buyMusicBox(TuneInfo info) {
  //   isLoading.value = true;
  //   buyMusicChannelApi(info.toneId ?? '');
  // }

  buyMusicBox(TuneInfo info) async {
    isLoading.value = true;
    String offerCode = await getOfferCode();
    GenericModel model = await buyMusicChannelApi(info.toneId ?? '', offerCode);
    if (model.respCode == 0) {
      openAlertPopup(
        message: model.message ?? '',
        onPrimary: () {
          if (onSuccess != null) {
            onSuccess!();
          }
        },
      );
      buySuccessfulEvent(
          TuneInfo(toneId: info.toneId, toneName: info.toneName));
      purchaseEvent(TuneInfo(toneId: info.toneId, toneName: info.toneName));
    } else {
      message.value = model.message ?? someThingWentWrongStr;
    }
    isLoading.value = false;
  }

  Future<String> getOfferCode() async {
    PackDetailModel result = await getPackDetailApi();
    if (result.respCode == 0) {
      try {
        return result.offers?.first.offerName ?? '';
      } catch (e) {
        print(" erorr while fetching pack name ====$e");
        return '';
      }
    } else {
      print("status code is ${result.respCode}");
      return '';
    }
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
    GenerateOtpScModel genModel = await generateOtpScApi(msisdn);
    if (genModel.respCode == 1000) {
      print("generateOtpApi $genModel");
      displayOptScreen.value = true;
      message.value = genModel.message ?? someThingWentWrongStr;
    } else {
      message.value = genModel.message ?? someThingWentWrongStr;
    }
    isLoading.value = false;
  }
}
