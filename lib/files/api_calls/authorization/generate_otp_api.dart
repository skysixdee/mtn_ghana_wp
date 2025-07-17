import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/generate_otp_sc_model.dart';
import 'package:mtn_ghana_wp/files/model/subscriber_validation_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<GenerateOtpScModel> generateOtpScApi(String msisdn) async {
  Map<String, dynamic> jsonData = {
    "msisdn": msisdn, //"98987654327",
    'transactionId': getTransactionId(),
    "type": "sms", //"sms"to send otp to user // "web" to get otp in response
  };
  Map<String, dynamic> map = await NetworkManager().post(generateOtpScUrl,
      jsonData:
          jsonData); //mockyapi:'https://run.mocky.io/v3/3c30486a-4291-4667-b575-ce6a66e3105b'
  return scGenerateOtpModelFromJson(json.encode(map));
}
