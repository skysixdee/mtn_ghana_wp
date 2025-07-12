import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/generic_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<GenericModel> buyMusicChannelApi(String toneId, String offerCode) async {
  Map<String, dynamic> jsonData = {
    "transactionId": getTransactionId(),
    "featureId": 1,
    "msisdn": StoreManager.msisdn,
    'offerCode': offerCode,
    "musicBoxId": toneId,
    "channelId": channelId,
    "language": StoreManager.languageCode,
  };
  Map<String, dynamic> jsonResp =
      await NetworkManager().post(buyMusicChannelUrl, jsonData: jsonData);
  return genericModelFromJson(json.encode(jsonResp));
}
