import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/generic_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<GenericModel> shuffleEnbleDisableApi(bool enable) async {
  Map<String, dynamic> formData = {
    "aPartyMsisdn": StoreManager.msisdn,
    "identifier": enable ? "activate" : "deactivate",
    "language": StoreManager.languageCode
  };

  Map<String, dynamic> jsonMap =
      await NetworkManager().post(shuffleEnableDisableUrl, formData: formData);
  GenericModel model = GenericModel.fromJson(jsonMap);
  return model;
}
