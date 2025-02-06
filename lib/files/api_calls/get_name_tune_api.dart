import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/name_tune_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<NameTuneModel> getNameTuneApi({int pageNo = 0}) async {
  String url =
      '${nameTuneUrl}language=${StoreManager.selectedLanguage}&categoryId=115&pageNo=$pageNo&perPageCount=$pagePerCount&searchLanguage=${StoreManager.selectedLanguage}';
  Map<String, dynamic> map = await NetworkManager().get(url);
  return nameTuneModelFromJson(json.encode(map));
}
