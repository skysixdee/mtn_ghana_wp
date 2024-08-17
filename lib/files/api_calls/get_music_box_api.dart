import 'dart:convert';

import 'package:etisalat/files/model/music_box_model.dart';
import 'package:etisalat/files/network_manager/network_manager.dart';
import 'package:etisalat/files/utility/urls.dart';

Future<MusicBoxModel> getMusicBoxApi() async {
  String url =
      '${musicBoxUrl}language=English&pageNo=0&perPageCount=20&type=MB';
  Map<String, dynamic> map = await NetworkManager().get(url);
  return musicBoxModelFromJson(json.encode(map));
}
