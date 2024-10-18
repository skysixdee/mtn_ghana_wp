import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/category_detail_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<CategoryDetailModel> getCategoryDetailApi(String key, String catId,
    {int pageNo = 0}) async {
  String lang = StoreManager.language;

  String url =
      '${categoryDetailUrl}language=$lang&sortBy=Order_By&alignBy=ASC&searchLanguage=$lang?searchKey=$key&genreDetailUrl&perPageCount=$pagePerCount&categoryId=$catId&pageNo=$pageNo';
  Map<String, dynamic> map = await NetworkManager().get(url);
  return categoryDetailModelFromJson(json.encode(map));
}
