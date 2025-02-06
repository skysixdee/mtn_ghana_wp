import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/my_tunes_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<MyTunesModel> getMyTuneApi({int pageNo = 0}) async {
  String lag = StoreManager.selectedLanguage;
  String msisdn = StoreManager.msisdn;

  String url =
      "$myTunesUrl?language=$lag&msisdn=$msisdn&startIndex=$pageNo&endIndex=$pagePerCount&rbtMode=400";
  Map<String, dynamic> map = await NetworkManager().get(url);
  return myTunesModelFromJson(json.encode(map));
}
