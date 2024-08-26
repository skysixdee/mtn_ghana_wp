import 'dart:convert';

import 'package:etisalat/files/model/create_blcklist_model.dart';
import 'package:etisalat/files/model/generic_model.dart';
import 'package:etisalat/files/network_manager/network_manager.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:etisalat/files/utility/get_transaction_id.dart';
import 'package:etisalat/files/utility/urls.dart';

Future<GenericModel> createBlackListApi(List<CreateBlacklistModel> list) async {
  List<Map<String, dynamic>> memberDetailList = [];
  for (var item in list) {
    memberDetailList
        .add({"bPartyName": item.name, 'bPartyMsisdn': item.msisdn});
  }

  Map<String, dynamic> jsonData = {
    "clientTxnId": getTransactionId(),
    "aPartyMsisdn": StoreManager.msisdn,
    "channelId": channelId,
    "memberDetailList": memberDetailList
  };
  Map<String, dynamic> jsonResp =
      await NetworkManager().post(createBlackListUrl, formData: jsonData);
  return genericModelFromJson(json.encode(jsonResp));
}
