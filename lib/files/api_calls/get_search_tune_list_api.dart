import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/search_result_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<SearchResultModel> getSearchedTuneListApi(String key,
    {int pageNo = 0}) async {
  Map<String, dynamic> jsonData = {
    "transactionId": getTransactionId(),
    "channelId": channelId,
    "msisdn": StoreManager.msisdn,
    "sortBy": "OrderBy",
    "pageNo": pageNo,
    "perPageCount": pagePerCount,
    "filter": "Content",
    "filterPref": 'begin',
    "locale": StoreManager.languageSort,
    "searchKey": [key],
  };

  String url = advanceSearchUrl;
  //"${searchUrl}language=$lang&sortBy=Order_By&perPageCount=$pagePerCount&searchLanguage=$lang&searchKey=$key&pageNo=$pageNo";
  Map<String, dynamic> map =
      await NetworkManager().post(url, jsonData: jsonData);
  return searchResultModelFromJson(json.encode(map));
}
