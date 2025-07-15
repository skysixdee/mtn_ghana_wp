import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/banner_detail_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<BannerDetailModel> getBannerDetailScApi(String type, String searchKey,
    {int pageNo = 0}) async {
  String url =
      "${bannerDetailScUrl}searchKey=$searchKey&languageCode=${StoreManager.languageSort}";
  Map<String, int> header = {"transId": getTransactionId()};
  Map<String, dynamic> response =
      await NetworkManager().get(url, addInHeader: [header]);
  BannerDetailModel model = BannerDetailModel.fromJson(response);
  return model;
  //return bannerDetailModelFromJson(_json);
}

String _json = """{
  "respCode": "SC0000",
  "message": "Success",
  "responseMap": {
    "bannerDetails": [
      {
        "toneId": "0022206",
        "artistName": "JACKIE N FRIENDS",
        "albumName": "NULL",
        "location": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=uq1WcINJSVQ=",
        "previewImage": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=uq1WcINJSVQ="
      }
    ]
  }
}
""";
