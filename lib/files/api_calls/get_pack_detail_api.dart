import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/pack_detail_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<PackDetailModel> getPackDetailApi() async {
  String url = getSubscriptionUrl;

  Map<String, dynamic> jsonData = {'msisdn': StoreManager.msisdn};
  Map<String, dynamic> map =
      await NetworkManager().post(url, jsonData: jsonData);
  return packDetailModelFromJson(json.encode(map));
}
