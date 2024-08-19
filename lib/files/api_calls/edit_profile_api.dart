import 'dart:convert';

import 'package:etisalat/files/model/edit_profile_model.dart';
import 'package:etisalat/files/network_manager/network_manager.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/get_transaction_id.dart';
import 'package:etisalat/files/utility/urls.dart';

Future<EditProfileModel> editProfileApi(List<String> categories) async {
  Map<String, dynamic> mapName = {
    "clientTxnId": getTransactionId(),
    "identifier": "UpdateUserName",
    "aPartyMsisdn": StoreManager.msisdn,
    "servType": 'UPDATE_USER_NAME',
    "language": StoreManager.language,
    "name": StoreManager.msisdn,
  };
  Map<String, dynamic> map = {
    "clientTxnId": getTransactionId(),
    "identifier": "UpdateCategories",
    "aPartyMsisdn": StoreManager.msisdn,
    "servType": 'UPDATE_CATAGORIES',
    "language": StoreManager.language,
    "categoryId": categories.join(','),
  };
  Map<String, dynamic> jsonMap =
      await NetworkManager().post(editProfileUrl, formData: map);
  return editProfileModelFromJson(json.encode(jsonMap));
}
