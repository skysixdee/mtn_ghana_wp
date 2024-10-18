import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/blackList_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<ViewBlackListModel> getBlackListApi() async {
  Map<String, dynamic> jsonData = {
    "clientTxnId": getTransactionId(),
    "serviceId": "1",
    "activityId": "4",
    "aPartyMsisdn": StoreManager.msisdn,
    "channelId": channelId,
    "rbtMode": "101",
  };
  Map<String, dynamic> jsonResp =
      await NetworkManager().post(getBlackListUrl, formData: jsonData);
  return viewBlackListModelFromJson(json.encode(jsonResp));
}
