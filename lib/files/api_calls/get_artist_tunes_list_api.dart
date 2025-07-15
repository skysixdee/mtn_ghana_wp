import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/artist_tune_list_model.dart';
import 'package:mtn_ghana_wp/files/model/search_result_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<SearchResultModel> getArtistTuneListScApi(String key,
    {int pageNo = 0}) async {
  Map<String, dynamic> jsonData = {
    "sortBy": "OrderBy",
    "pageNo": pageNo,
    "perPageCount": pagePerCount,
    "filter": "Artist",
    "filterPref": "begin",
    "locale": StoreManager.languageSort,
    "searchKey": [key]
  };
  Map<String, dynamic> map = await NetworkManager().post(advanceSearchUrl,
      jsonData:
          jsonData); //mockyapi:'https://run.mocky.io/v3/3c30486a-4291-4667-b575-ce6a66e3105b'
  return searchResultModelFromJson(
      json.encode(map)); //artistTuneListModelFromJson(json.encode(map));
}
