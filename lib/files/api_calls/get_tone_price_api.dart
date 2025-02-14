import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/generic_model.dart';
import 'package:mtn_ghana_wp/files/model/get_tone_price_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<GetTonePriceModell> getTonePriceApi() async {
  Map<String, dynamic> jsonData = {
    "language": StoreManager.languageCode,
    "serviceId": "1",
    "clientTxnId": getTransactionId(),
    "aPartyMsisdn": StoreManager.msisdn,
    "bPartyMsisdnList": "",
    "toneId": "6641481",
    "validationIdentifier": "3",
    "channelId": channelId
  };
  Map<String, dynamic> jsonResp =
      await NetworkManager().post(getTonePriceUrl, formData: jsonData);
  return getTonePriceModelFromJson(json.encode(jsonResp));
}
