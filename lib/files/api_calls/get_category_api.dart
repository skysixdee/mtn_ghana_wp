import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/category_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<CategoryModel> getCategoryApi() async {
  String url = '$categoryUrl${StoreManager.selectedLanguage}';
  Map<String, dynamic> map = await NetworkManager().get(url);
  return categoryModelFromJson(json.encode(map));
}

Future<CategoryModel> getCategoryScApi() async {
  String url = categoryScUrl;
  //"${categoryScUrl}languageCode=${StoreManager.languageSort}&categoryValue=4";
  Map<String, int> header = {"transId": getTransactionId()};
  Map<String, dynamic> map =
      await NetworkManager().get(url, addInHeader: [header]);
  return categoryModelFromJson(json.encode(map));
}