import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/generic_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<GenericModel> giftTuneApi(String bParty, String toneId) async {
  Map<String, dynamic> jsonRequest = {
    'transactionId': getTransactionId(),
    "featureId": 1,
    'msisdn': StoreManager.msisdn,
    'contentId': toneId,
    'contentType': 1,
    'languageCode': StoreManager.languageCode,
    'channelId': channelId,
    "userData": "selftest",
    'bmsisdn': bParty,
  };
  Map<String, dynamic> jsonResp =
      await NetworkManager().post(sendGiftScUrl, jsonData: jsonRequest);
  return genericModelFromJson(json.encode(jsonResp));
}
