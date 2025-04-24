import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/app_setting_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

getAppSettingApi() async {
  Map<String, dynamic> map = await NetworkManager().get(settingScUrl);
  AppSettingModel appSettingModel = appSettingModelFromJson(json.encode(map));
  StoreManager.other = appSettingModel; //appSettingModel.responseMap?.settings?.others;
print("----------------------gokul----------------${jsonEncode(appSettingModel.toJson())}");
}
