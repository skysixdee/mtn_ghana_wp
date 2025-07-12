import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/generic_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<GenericModel> deleteMusicBoxApi(String id) async {
  Map<String, dynamic> jsonData = {
    "transactionId": getTransactionId(),
    "featureId": 1,
    "msisdn": StoreManager.msisdn,
    "offerCode": musicBoxOfferCode,
    "musicBoxId": id,
    "languageCode": StoreManager.languageSort,
    "channelId": channelId,
    "userData": "selftest"
  };
  Map<String, dynamic> resp = await NetworkManager()
      .post(deleteMusicBoxSubscriptionUrl, jsonData: jsonData);
  return genericModelFromJson(json.encode(resp));
}
