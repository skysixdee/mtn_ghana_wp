import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/search_result_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<SearchResultModel> getSearchedTuneListApi(String key,
    {int pageNo = 0}) async {
  String lang = StoreManager.language;
  String url =
      "${searchUrl}language=$lang&sortBy=Order_By&perPageCount=$pagePerCount&searchLanguage=$lang&searchKey=$key&pageNo=$pageNo";
  Map<String, dynamic> map = await NetworkManager().get(url);
  return searchResultModelFromJson(json.encode(map));
}
