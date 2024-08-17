import 'dart:convert';

import 'package:etisalat/files/model/music_box_model.dart';
import 'package:etisalat/files/network_manager/network_manager.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:etisalat/files/utility/urls.dart';

Future<MusicBoxModel> getMusicBoxApi({int pageNo = 0}) async {
  String url =
      '${musicBoxUrl}language=${StoreManager.language}&pageNo=$pageNo&perPageCount=$pagePerCount&type=MB';
  Map<String, dynamic> map = await NetworkManager().get(url);
  return musicBoxModelFromJson(json.encode(map));
}
