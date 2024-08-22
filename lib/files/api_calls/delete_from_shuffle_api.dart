import 'dart:convert';

import 'package:etisalat/files/model/generic_model.dart';
import 'package:etisalat/files/network_manager/network_manager.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:etisalat/files/utility/get_transaction_id.dart';
import 'package:etisalat/files/utility/urls.dart';

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
