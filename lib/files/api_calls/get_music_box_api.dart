import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/music_box_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<MusicBoxModel> getMusicBoxApi({int pageNo = 0}) async {
  String url =
      '${musicBoxUrl}language=${StoreManager.selectedLanguage}&pageNo=$pageNo&perPageCount=$pagePerCount&type=MB';
  Map<String, dynamic> map = await NetworkManager().get(url);
  return musicBoxModelFromJson(json.encode(map));
}
