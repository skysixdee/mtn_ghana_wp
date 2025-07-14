import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/search_result_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<SearchResultModel> getToneCodeSearchListApi(String key,
    {int pageNo = 0}) async {
  Map<String, dynamic> jsonData = {
    "sortBy": "OrderBy",
    "pageNo": pageNo,
    "perPageCount": pagePerCount,
    "filter": "ToneId",
    "filterPref": "custom",
    "locale": StoreManager.languageSort,
    "msisdn": StoreManager.msisdn,
    "searchKey": [key]
  };

  String url = advanceSearchUrl;

  Map<String, dynamic> map =
      await NetworkManager().post(url, jsonData: jsonData);
  return searchResultModelFromJson(json.encode(map));
}
