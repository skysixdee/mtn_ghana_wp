import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/confirm_otp_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<ConfirmOtpModel> confirmOtpApi(String msisdn, String otp) async {
  Map<String, dynamic> formData = {
    "msisdn": msisdn,
    "language": StoreManager.selectedLanguage,
    "otp": otp
  };
  Map<String, dynamic> jsonResp =
      await NetworkManager().post(confirmOtpUrl, formData: formData);
  return confirmOtpModelFromJson(json.encode(jsonResp));
}
