import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/generic_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<GenericModel> deleteFromShuffleApi(
    String toneId, String timeType) async {
  Map<String, dynamic> jsomForm = {
    "clientTxnId": getTransactionId(),
    "aPartyMsisdn": StoreManager.msisdn,
    "toneIdList": [
      {"toneId": toneId}
    ],
    "language": StoreManager.languageCode,
    "priority": "0",
    "channelId": channelId,
    "timeType": timeType,
    "activityId": "3",
    "serviceId": "17"
  };
  Map<String, dynamic> map =
      await NetworkManager().post(deleteFromShuffleUrl, formData: jsomForm);
  return genericModelFromJson(json.encode(map));
}


Future<GenericModel> deleteFromShuffleScApi(
    String contentId, String timeType) async {
  Map<String, dynamic> jsomForm = {
    "transactionId": getTransactionId(),
    "featureId" : 1,
    "msisdn": StoreManager.msisdn,
    "channelId": channelId,
    "contentIdlist": [
      {"contentId": contentId}
    ]
  };
  Map<String, dynamic> map =
      await NetworkManager().post(deleteFromShuffleScUrl, jsonData: jsomForm);
  return genericModelFromJson(json.encode(map));
}