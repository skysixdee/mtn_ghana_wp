import 'dart:convert';

import 'package:mtn_ghana_wp/files/api_calls/get_app_setting.dart';
import 'package:mtn_ghana_wp/files/model/artist_tune_list_model.dart';
import 'package:mtn_ghana_wp/files/model/search_result_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<SearchResultModel> searchNameTuneApi(String key,
    {int pageNo = 0}) async {
  String lang = StoreManager.selectedLanguage;
  // if (StoreManager.other == null) {
  //   await getAppSettingApi();
  // }
  String catId =
      nameTuneCategoryId; //StoreManager.other?.nameTuneCategoryid?.attribute ?? '';
  String url =
      '$searchNameTuneUrl?language=$lang&categoryId=$catId&pageNo=$pageNo&perPageCount=$pagePerCount&searchLanguage=$lang';
  Map<String, dynamic> jsonResp = await NetworkManager().get(url, addInHeader: [
    {'searchkey': key}
  ]);
  return searchResultModelFromJson(json.encode(jsonResp));
}
