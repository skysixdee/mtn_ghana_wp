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
    "sortBy": "OrderBy",
    "pageNo": pageNo,
    "perPageCount": pagePerCount,
    "filter": "Content",
    "filterPref": "custom",
    "locale": StoreManager.languageSort,
    "msisdn": StoreManager.msisdn,
    "searchKey": [key]
  };

  String url = advanceSearchUrl;
  //"${searchUrl}language=$lang&sortBy=Order_By&perPageCount=$pagePerCount&searchLanguage=$lang&searchKey=$key&pageNo=$pageNo";
  Map<String, dynamic> map =
      await NetworkManager().post(url, jsonData: jsonData);
  return searchResultModelFromJson(json.encode(map));
  //return searchResultModelFromJson(_json);
}

String _json = """{
  "responseMap": {
    "toneList": [
      {
        "toneId": "58812663",
        "toneName": "Shiver",
        "artistName": "Cold Play",
        "albumName": "Live",
        "price": 300,
        "categoryId": 26,
        "expiryDate": "Tue Dec 30 17:30:00 UTC 2025",
        "toneIdStreamingUrl": "https://funtone.ooredoo.com.mm/stream-media/get-tone-path?fileId=B+HYDdcS0GzfRp5KT5lW1Q==",
        "toneIdpreviewImageUrl": "https://funtone.ooredoo.com.mm/stream-media/get-preview-image?fileId=B+HYDdcS0GzfRp5KT5lW1Q=="
      }
    ]
  },
  "message": "Success",
  "respTime": "Response Time",
  "statusCode": "SC0000"
}
""";
