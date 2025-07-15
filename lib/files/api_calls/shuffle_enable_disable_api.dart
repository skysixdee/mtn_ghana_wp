import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/generic_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<GenericModel> shuffleEnbleDisableApi(bool enable) async {
  Map<String, dynamic> formData = {
    "transactionId": getTransactionId(),
    'featureId': 1,
    "msisdn": StoreManager.msisdn,
    'channelId': channelId,
    "mode": enable ? "0" : "1",
    "languageCode": StoreManager.languageCode,
  };

  Map<String, dynamic> jsonMap =
      await NetworkManager().post(shuffleEnableDisableUrl, formData: formData);
  GenericModel model = GenericModel.fromJson(jsonMap);
  return model;
}
