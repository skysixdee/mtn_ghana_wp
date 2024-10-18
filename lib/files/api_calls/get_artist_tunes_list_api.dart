import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/artist_tune_list_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<ArtistTuneListModel> getArtistTuneListApi(String key,
    {int pageNo = 0}) async {
  String lag = StoreManager.language;
  String url =
      '${artistTuneSearchUrl}language=$lag&artistKey=$key&sortBy=Order_By&alignBy=ASC&pageNo=$pageNo&searchLanguage=$key&perPageCount=$pagePerCount';
  Map<String, dynamic> jsonResp = await NetworkManager().get(url);
  return artistTuneListModelFromJson(json.encode(jsonResp));
}
