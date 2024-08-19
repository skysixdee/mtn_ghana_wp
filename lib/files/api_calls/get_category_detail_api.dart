import 'dart:convert';

import 'package:etisalat/files/model/category_detail_model.dart';
import 'package:etisalat/files/network_manager/network_manager.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:etisalat/files/utility/urls.dart';

Future<CategoryDetailModel> getCategoryDetailApi(String key, String catId,
    {int pageNo = 0}) async {
  String lang = StoreManager.language;

  String url =
      '${categoryDetailUrl}language=$lang&sortBy=Order_By&alignBy=ASC&searchLanguage=$lang?searchKey=$key&genreDetailUrl&perPageCount=$pagePerCount&categoryId=$catId&pageNo=$pageNo';
  Map<String, dynamic> map = await NetworkManager().get(url);
  return categoryDetailModelFromJson(json.encode(map));
}
