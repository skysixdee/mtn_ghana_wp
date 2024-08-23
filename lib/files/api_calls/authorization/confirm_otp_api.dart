import 'dart:convert';

import 'package:etisalat/files/model/confirm_otp_model.dart';
import 'package:etisalat/files/network_manager/network_manager.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/get_transaction_id.dart';
import 'package:etisalat/files/utility/urls.dart';

Future<ConfirmOtpModel> confirmOtpApi(String msisdn, String otp) async {
  Map<String, dynamic> formData = {
    "msisdn": msisdn,
    "language": StoreManager.language,
    "otp": otp
  };
  Map<String, dynamic> jsonResp =
      await NetworkManager().post(confirmOtpUrl, formData: formData);
  return confirmOtpModelFromJson(json.encode(jsonResp));
}
