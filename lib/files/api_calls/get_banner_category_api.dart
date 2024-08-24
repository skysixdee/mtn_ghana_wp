import 'dart:convert';

import 'package:etisalat/files/model/artist_tune_list_model.dart';
import 'package:etisalat/files/network_manager/network_manager.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:etisalat/files/utility/urls.dart';

Future<ArtistTuneListModel> getBannerCategoryApi(String type, String categoryId,
    {int pageNo = 0}) async {
  String language = StoreManager.language;

  var url =
      "${artistTuneSearchUrl}language=$language&searchKey=$type&categoryId=$categoryId&sortBy=Order_By&alignBy=ASC&pageNo=$pageNo&searchLanguage=$language&perPageCount=$pagePerCount";
  //getBannerCategoryApi(type, categoryId);
  Map<String, dynamic> jsonMap = await NetworkManager().get(url);
  return artistTuneListModelFromJson(json.encode(jsonMap));
}
