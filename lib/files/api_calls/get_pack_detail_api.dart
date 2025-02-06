import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/pack_detail_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<PackDetailModel> getPackDetailApi() async {
  String url =
      "${packDetailUrl}msisdn=${StoreManager.msisdn}&language=${StoreManager.selectedLanguage}";
  Map<String, dynamic> map = await NetworkManager().get(url);
  return packDetailModelFromJson(json.encode(map));
}
