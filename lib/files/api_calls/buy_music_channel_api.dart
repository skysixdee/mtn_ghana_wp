import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/generic_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<GenericModel> buyMusicChannelApi(String toneId) async {
  Map<String, dynamic> jsonData = {
    "clientTxnId": getTransactionId(),
    "aPartyMsisdn": StoreManager.msisdn,
    "toneId": toneId,
    "channelId": channelId,
    "language": StoreManager.languageCode,
    "serviceId": "1",
    "priority": "0",
    "paymentMode": " "
  };
  Map<String, dynamic> jsonResp =
      await NetworkManager().post(buyMusicChannelUrl, formData: jsonData);
  return genericModelFromJson(json.encode(jsonResp));
}
