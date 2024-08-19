import 'dart:convert';

import 'package:etisalat/files/model/banner_detail_model.dart';
import 'package:etisalat/files/network_manager/network_manager.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:etisalat/files/utility/urls.dart';

Future<BannerDetailModel> getBannerDetailApi(String type, String searchKey,
    {int pageNo = 0}) async {
  String lang = StoreManager.language;
  String url =
      '${bannerDetailUrl}language=$lang&pageNo=$pageNo&pagePerCount=$pagePerCount&type=$type&searchKey=$searchKey';
  Map<String, dynamic> map = await NetworkManager().get(url);
  return bannerDetailModelFromJson(json.encode(map));
}
