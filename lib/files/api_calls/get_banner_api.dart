import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/banner_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

// Future<BannerModel> getBannerApi() async {
//   String url = '$bannerUrl${StoreManager.selectedLanguage}';
//   Map<String, dynamic> map = await NetworkManager().get(url);
//   return bannerModelFromJson(json.encode(map));
// }

Future<BannerModel> getBannerScApi() async {
  String url = getBannerListScUrl;
  //"${bannerScUrl}channelId=2&languageCode=${StoreManager.languageSort}";
  //  Map<String, int> header = {"transId": getTransactionId()};
  Map<String, dynamic> response = await NetworkManager().get(url);
  BannerModel model = BannerModel.fromJson(response);
  return model;
}
