import 'package:mtn_ghana_wp/files/api_calls/authorization/generate_otp_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/authorization/new_user_registration_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/authorization/security_token_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/authorization/subscriber_validation_api.dart';
import 'package:mtn_ghana_wp/files/model/generate_otp_sc_model.dart';
import 'package:mtn_ghana_wp/files/model/get_security_token_model.dart';
import 'package:mtn_ghana_wp/files/model/newUserRegistrationModel.dart';
import 'package:mtn_ghana_wp/files/model/security_token_model.dart';
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
  bool isNewUser = false;
  String securityToken='';
  RxBool displayOptScreen = false.obs;
  int expireTime = 5;
  @override
  void onInit() {
    super.onInit();
    customPrint("LoginController  onInit");
  }

  resetValue() {
    isNewUser = false;
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
    isNewUser = false;
    isLoading.value = true;
    //SubscriberValidationModel model = await susbcriberValidationApi(msisdn);
    //if (model.statusCode == 'SC0000') {
      // if (model.responseMap?.respCode == "SC0000") {
        GenerateOtpScModel genModel = await generateOtpScApi(msisdn);
        if (genModel.respCode ==1000) {
          displayOptScreen.value = true;
        } else {
          message.value = genModel.message ?? someThingWentWrongStr;
          isLoading.value = false;
        }
      //} else if (model.responseMap?.respCode == "100") {
        //new user
        SecurityTokenModel model = await getSecurityTokenApi();

        if (model.statusCode == "SC0000") {
          isNewUser = true;
          NewUserRegistrationModel respo = await newUserRegistration(
              msisdn, model.responseMap?.securityCounter ?? "");
          if (respo.statusCode == "SC0000") {
            securityToken=respo.responseMap.secToc??"";
            displayOptScreen.value = true;
          } else {
            message.value = someThingWentWrongStr;
            isLoading.value = false;
          }
        }
        //getSecurityToken(false, true);
      // } else {
      //   message.value = model.message ?? someThingWentWrongStr;
      //   isLoading.value = false;
      // }
      //displayOptScreen.value = true;
    // } else {
    //   message.value = model.message ?? someThingWentWrongStr;
    //   isLoading.value = false;
    // }

    isLoading.value = false;
  }

  onChangeMsidn(String value) {
    message.value = '';
    msisdn = value;
    enableButton.value = value.length >= msisdnLength;
  }
}
