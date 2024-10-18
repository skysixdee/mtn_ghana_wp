import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/generic_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<GenericModel> deleteMyTuneApi(String tuneId, String packName) async {
  //$baseUrl
  Map<String, dynamic> jsonData = {
    'msisdn': StoreManager.msisdn,
    'toneId': tuneId,
    'packName': packName,
    'language': StoreManager.languageCode,
  };
  Map<String, dynamic> jsonResp =
      await NetworkManager().post(deleteMyTuneUrl, formData: jsonData);
  return genericModelFromJson(json.encode(jsonResp));
}
