import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/banner_detail_model.dart';
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

  Map<String, int> header = {"transId": getTransactionId()};
  Map<String, dynamic> response =
      await NetworkManager().get(url, addInHeader: [header]);
  BannerModel model = BannerModel.fromJson(response);
  return model;

  //return homeBannerModelFromJson(_json);
}

String _json = """{
  "respCode": "SC0000",
  "message": "SUCCESS",
  "responseMap": {
    "bannerList": [
      {
        "language": "English",
        "bannerId": "2878",
        "bannerPath": "http://10.135.64.104:8123/stream-media/get-banner-image?bannerId=2878&isMobileBanner=1&isEnglish=1",
        "type": "PromoCode",
        "searchKey": "6803415",
        "bannerOrder": "1"
      },
      {
        "language": "English",
        "bannerId": "2879",
        "bannerPath": "http://10.135.64.104:8123/stream-media/get-banner-image?bannerId=2879&isMobileBanner=1&isEnglish=1",
        "type": "PromoCode",
        "searchKey": "9603452",
        "bannerOrder": "2"
      },
      {
        "language": "English",
        "bannerId": "2880",
        "bannerPath": "http://10.135.64.104:8123/stream-media/get-banner-image?bannerId=2880&isMobileBanner=1&isEnglish=1",
        "type": "PromoCode",
        "searchKey": "6642212",
        "bannerOrder": "3"
      },
      {
        "language": "English",
        "bannerId": "2881",
        "bannerPath": "http://10.135.64.104:8123/stream-media/get-banner-image?bannerId=2881&isMobileBanner=1&isEnglish=1",
        "type": "PromoCode",
        "searchKey": "0022206",
        "bannerOrder": "4"
      },
      {
        "language": "English",
        "bannerId": "2882",
        "bannerPath": "http://10.135.64.104:8123/stream-media/get-banner-image?bannerId=2882&isMobileBanner=1&isEnglish=1",
        "type": "PromoCode",
        "searchKey": "0012078",
        "bannerOrder": "5"
      }
    ]
  }
}
""";
