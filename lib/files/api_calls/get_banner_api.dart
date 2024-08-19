import 'dart:convert';

import 'package:etisalat/files/model/banner_model.dart';
import 'package:etisalat/files/network_manager/network_manager.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/urls.dart';

Future<BannerModel> getBannerApi() async {
  String url = '$bannerUrl${StoreManager.language}';
  Map<String, dynamic> map = await NetworkManager().get(url);
  return bannerModelFromJson(json.encode(map));
}
