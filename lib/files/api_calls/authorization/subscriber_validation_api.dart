import 'dart:convert';

import 'package:etisalat/files/model/subscriber_validation_model.dart';
import 'package:etisalat/files/network_manager/network_manager.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/get_transaction_id.dart';
import 'package:etisalat/files/utility/urls.dart';

Future<SubscriberValidationModel> susbcriberValidationApi(String msisdn) async {
  Map<String, dynamic> jsonData = {
    "language": StoreManager.language,
    "clientTxnId": getTransactionId(),
    "type": "CheckMsisdnSendOTP",
  };

  Map<String, dynamic> jsonResp = await NetworkManager()
      .post(subscriberValidationUrl, formData: jsonData, addInHeader: [
    {'msisdn': msisdn}
  ]);
  print("json respo ==== ${jsonResp}");
  return subscriberValidationModelFromJson(json.encode(jsonResp));
}
