import 'dart:convert';

import 'package:etisalat/files/model/regenerate_model.dart';
import 'package:etisalat/files/network_manager/network_manager.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/urls.dart';

Future<RegenerateModel> regenerateTokenApi() async {
  Map<String, dynamic> map = {
    "refreshToken": StoreManager.refreshToken,
  };
  Map<String, dynamic> jsonResp =
      await NetworkManager().post(reGenerateTokenUrl, formData: map);
  return regenerateModelFromJson(json.encode(jsonResp));
}
