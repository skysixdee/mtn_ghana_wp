import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/buy_tone_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

activateBasePackApi() async {
  Map<String, dynamic> jsomData = {
    'transactionId': "${getTransactionId()}",
    "featureId": 1,
    'msisdn': StoreManager.msisdn,
    'channelId': channelId,
  };
  Map<String, dynamic> jsonResp =
      await NetworkManager().post(setToneUrl, jsonData: jsomData);
  return buyToneModelFromJson(
      json.encode(jsonResp)); //genericModelFromJson(json.encode(jsonResp));
}
