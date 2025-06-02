import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/artist_tune_list_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<ArtistTuneListModel> getArtistTuneListApi(String key,
    {int pageNo = 0}) async {
  String lag = StoreManager.selectedLanguage;
  String url =
      '${artistTuneSearchUrl}language=$lag&artistKey=$key&sortBy=Order_By&alignBy=ASC&pageNo=$pageNo&searchLanguage=$key&perPageCount=$pagePerCount';
  Map<String, dynamic> jsonResp = await NetworkManager().get(url);
  return artistTuneListModelFromJson(json.encode(jsonResp));
}



Future<ArtistTuneListModel> getArtistTuneListScApi(String key, {int pageNo = 0}) async {
  
   Map<String, dynamic> jsonData = {
      "sortBy": "OrderBy",
    "pageNo": pageNo,
    "perPageCount": pagePerCount,
    "filter": "Content",
    "filterPref": "begin",
    "locale": StoreManager.languageSort,
    "searchKey": [
        key
    ]


  };
  Map<String, dynamic> map = await NetworkManager().post(artistTuneSearchScUrl,
      jsonData:
          jsonData); //mockyapi:'https://run.mocky.io/v3/3c30486a-4291-4667-b575-ce6a66e3105b'
  return artistTuneListModelFromJson(json.encode(map));
 

}
