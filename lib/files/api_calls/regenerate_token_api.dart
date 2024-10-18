import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/regenerate_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<RegenerateModel> regenerateTokenApi() async {
  Map<String, dynamic> map = {
    "refreshToken": StoreManager.refreshToken,
  };
  Map<String, dynamic> jsonResp =
      await NetworkManager().post(reGenerateTokenUrl, formData: map);
  return regenerateModelFromJson(json.encode(jsonResp));
}
