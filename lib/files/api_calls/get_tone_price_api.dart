import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/generic_model.dart';
import 'package:mtn_ghana_wp/files/model/get_tone_price_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<GetTonePriceModel> getTonePriceScApi(String toneId) async {
  Map<String, dynamic> jsonData = {
    "transactionId": getTransactionId(),
    "featureId": "1",
    "channelId": channelId,
    "languageCode": StoreManager.languageCode,
    "msisdn": StoreManager.msisdn
  };
  Map<String, dynamic> jsonResp =
      await NetworkManager().post(getTonePriceScUrl, jsonData: jsonData);
  return getTonePriceModelFromJson(json.encode(jsonResp));
}
