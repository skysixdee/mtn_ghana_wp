import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/category_model.dart';
import 'package:mtn_ghana_wp/files/model/category_mw_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<CategoryMwModel> getCategoryApi() async {
  String url =categoryScUrl;
  //"https://crbt.mtn.co.sz/apigw/Middleware/api/adapter/v1/crbt/categories?English"; 
  //'$categoryUrl${StoreManager.selectedLanguage}';
  Map<String, dynamic> map = await NetworkManager().get(url);
  return categoryMwModelFromJson(json.encode(map));
}

//----------sc api--------------------
Future<CategoryModel> getCategoryScApi() async {
  String url = categoryScUrl;
  //"${categoryScUrl}languageCode=${StoreManager.languageSort}&categoryValue=4";
  Map<String, int> header = {"transId": getTransactionId()};
  Map<String, dynamic> map =
      await NetworkManager().get(url, addInHeader: [header]);
  return categoryModelFromJson(json.encode(map));
}