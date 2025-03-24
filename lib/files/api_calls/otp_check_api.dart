import 'package:mtn_ghana_wp/files/model/new_user_otp_check_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<NewUserCheckOtpModel> otpCheckApi(
    String otp, String msisdn, String securityToken) async {
  var url = checkOtpNewUserUrl;

  Map<String, String> myPost = {
    "otp": otp,
    "msisdn": msisdn,
    "language": StoreManager.selectedLanguage,
    "clientTxnId": "${getTransactionId()}",
    "secToc": securityToken,
    "type": "ValidateDetails"
  };

  Map<String, dynamic> jsonResp =
      await NetworkManager().post(url, formData: myPost);
  NewUserCheckOtpModel model = NewUserCheckOtpModel.fromJson(jsonResp);
  return model;
}
