import 'dart:convert';

import 'package:etisalat/files/model/category_model.dart';
import 'package:etisalat/files/network_manager/network_manager.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/urls.dart';

Future<CategoryModel> getCategoryApi() async {
  String url = '$categoryUrl${StoreManager.language}';
  Map<String, dynamic> map = await NetworkManager().get(url);
  return categoryModelFromJson(json.encode(map));
}
