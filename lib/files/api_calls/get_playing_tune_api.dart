import 'dart:convert';

import 'package:etisalat/files/model/my_playing_tunes_model.dart';
import 'package:etisalat/files/network_manager/network_manager.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:etisalat/files/utility/urls.dart';

Future<MyPlayingTunesModel> getMyPlayingTuneApi({int pageNo = 0}) async {
  String lag = StoreManager.language;
  String msisdn = StoreManager.msisdn;
  String url =
      "$playingTuneUrl?language=$lag&msisdn=$msisdn&startIndex=$pageNo&endIndex=$pagePerCount&rbtMode=0";
  Map<String, dynamic> map = await NetworkManager().get(url);
  return myPlayingTunesModelFromJson(json.encode(map));
}
