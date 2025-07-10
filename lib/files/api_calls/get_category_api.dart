import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/category_model.dart';

import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';

import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<CategoryModel> getCategoryScApi() async {
  Map<String, dynamic> map = await NetworkManager().get(getCategoryListUrl);
  return categoryModelFromJson(json.encode(map));
}
