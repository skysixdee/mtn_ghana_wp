import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/generic_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<GenericModel> dedicatedTuneDeleteScApi(
    String bParty, String toneId, String timeType) async {
  Map<String, dynamic> jsomForm = {
    "transactionId": getTransactionId(), //"102030238",
    "featureId": 1,
    "msisdn": StoreManager.msisdn, //"94000001",
    "bmsisdn": bParty, //"92000001",
    "channelId": 2
  };
  Map<String, dynamic> map =
      await NetworkManager().post(deleteDedicatedTuneUrl, jsonData: jsomForm);
  return genericModelFromJson(json.encode(map));
}
