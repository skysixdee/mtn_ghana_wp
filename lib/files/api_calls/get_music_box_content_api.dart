import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/music_box_content_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<MusicBoxContentModel> getMusicBoxContentApi(String type, String code,
    {int pageNo = 0}) async {
  String url =
      '${musicBoxContextUrl}language=${StoreManager.language}&pageNo=$pageNo&perPageCount=$pagePerCount&type=$type&toneCode=$code';
  Map<String, dynamic> map = await NetworkManager().get(url);
  return musicBoxContentModelFromJson(json.encode(map));
}
