import 'dart:convert';
import 'package:mtn_ghana_wp/files/model/music_box_mw_model.dart';
import 'package:mtn_ghana_wp/files/model/music_box_sc_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<MusicBoxScModel> getMusicBoxScApi({int pageNo = 0}) async {
  Map<String, dynamic> jsonData = {
    "transactionId": getTransactionId(),
    "languageCode": StoreManager.languageSort,
    "type": "MB",
    "pageNo": pageNo,
    "perPageCount": pagePerCount
  };
  Map<String, dynamic> map =
      await NetworkManager().post(getMusicBoxListUrl, jsonData: jsonData);
  return musicBoxScModelFromJson(json.encode(map));
  //return musicBoxScModelFromJson(_jsonResp);
}

String _jsonResp = """{
  "respCode": 0,
  "message": "Success",
  "respTime": "2025-07-09 17:48:24",
  "musicBoxList": [
    {
      "musicBoxId": "991",
      "musicBoxName": "Africa",
      "musicBoxIdpreviewImageUrl": "https://funtone.ooredoo.com.mm/stream-media/get-preview-image?fileId=fkIoInc2ZsA="
    },
    {
      "musicBoxId": "991",
      "musicBoxName": "Africa",
      "musicBoxIdpreviewImageUrl": "https://funtone.ooredoo.com.mm/stream-media/get-preview-image?fileId=fkIoInc2ZsA="
    },
    {
      "musicBoxId": "991",
      "musicBoxName": "Africa",
      "musicBoxIdpreviewImageUrl": "https://funtone.ooredoo.com.mm/stream-media/get-preview-image?fileId=fkIoInc2ZsA="
    }
  ]
}
""";
