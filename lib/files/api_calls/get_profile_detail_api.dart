import 'dart:convert';

import 'package:etisalat/files/model/profile_detail_model.dart';
import 'package:etisalat/files/network_manager/network_manager.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/get_transaction_id.dart';
import 'package:etisalat/files/utility/urls.dart';

Future<ProfileDetailModel> getProfileDetailApi() async {
  Map<String, dynamic> map = {
    "clientTxnId": getTransactionId(),
    "aPartyMsisdn": StoreManager.msisdn,
    "identifier": "GetUserDetails",
    "language": StoreManager.language,
  };
  Map<String, dynamic> jsonMap =
      await NetworkManager().post(profileDetailUrl, formData: map);
  return profileDetailModelFromJson(json.encode(jsonMap));
}
