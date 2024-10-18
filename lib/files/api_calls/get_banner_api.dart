import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/banner_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<BannerModel> getBannerApi() async {
  String url = '$bannerUrl${StoreManager.language}';
  Map<String, dynamic> map = await NetworkManager().get(url);
  return bannerModelFromJson(json.encode(map));
}
