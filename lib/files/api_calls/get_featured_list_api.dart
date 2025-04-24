import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/advanced_search_model.dart';
import 'package:mtn_ghana_wp/files/model/fetured_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<FeturedModel> getFeaturedListApi(String identifier,
    {String pageNo = "0"}) async {
  String lang = StoreManager.selectedLanguage;
  String msisdn = StoreManager.msisdn;
  int tId = getTransactionId();

  String url =
      "${featuredUrl}language=$lang&msisdn=$msisdn&clientTxnId=$tId&identifier=$identifier&pageNo=$pageNo&perPageCount=$pagePerCount";
  Map<String, dynamic> map = await NetworkManager().get(url);
  return feturedModelFromJson(json.encode(map));
}

Future<AdvancedSearchModal> advancedSearchScApi(
  String catId,
  {String pageNo = "0"}
  //String searchedKey,
  //int pageNo,
) async {
  Map<String, dynamic> jsomForm = {
    "sortBy": "OrderBy",
    "pageNo": pageNo,
    "perPageCount": 20,
    "filter": "Content",
    "filterPref": "custom",
    "locale": "en",
    "searchKey":["SKY"],
    "categoryId": [catId], //[StoreManager.categories]
  };
  Map<String, dynamic> map = await NetworkManager().post(advancedSearchScUrl,
      jsonData:
          jsomForm); //mockyapi:'https://run.mocky.io/v3/3c30486a-4291-4667-b575-ce6a66e3105b'
  return advancedSearchModalFromJson(json.encode(map));
}
