import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/category_model.dart';

import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';

import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<CategoryModel> getCategoryScApi() async {
  Map<String, int> header = {"transId": getTransactionId()};
  Map<String, dynamic> map =
      await NetworkManager().get(getCategoryListUrl, addInHeader: [header]);
  return categoryModelFromJson(json.encode(map));
}
