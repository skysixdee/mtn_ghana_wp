import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/music_box_content_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<MusicBoxContentModel> getMusicBoxContentApi(String id,
    {int pageNo = 0}) async {
  Map<String, dynamic> jsonData = {
    "transactionId": getTransactionId(), //4564336682,
    "languageCode": StoreManager.languageSort,
    "musicBoxId": id
  };
  Map<String, dynamic> map =
      await NetworkManager().post(getMusicBoxToneListUrl, jsonData: jsonData);
  return musicBoxContentModelFromJson(json.encode(map));
  //return musicBoxContentModelFromJson(_jsonResp);
}

String _jsonResp = """{
  "respCode": 0,
  "message": "Success",
  "respTime": "2025-07-15 10:15:28",
  "responseMap": {
    "toneList": [
      {
        "toneId": "3193426",
        "toneName": "Wish me well",
        "artistName": "Kuame Eugene",
        "albumName": "Album",
        "categoryId": 202,
        "toneIdStreamingUrl": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=ieh+Uot4IAk=",
        "toneIdpreviewImageUrl": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=ieh+Uot4IAk="
      },
      {
        "toneId": "3763417",
        "toneName": "Transformer",
        "artistName": "Strongman",
        "albumName": "Album",
        "categoryId": 202,
        "toneIdStreamingUrl": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=RefG6yw+jmM=",
        "toneIdpreviewImageUrl": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=RefG6yw+jmM="
      },
      {
        "toneId": "4943415",
        "toneName": "Thunder",
        "artistName": "EPHRAIM",
        "albumName": "Album",
        "categoryId": 202,
        "toneIdStreamingUrl": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=dh363iHotfc=",
        "toneIdpreviewImageUrl": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=dh363iHotfc="
      },
      {
        "toneId": "7833425",
        "toneName": "Bend Down",
        "artistName": "Okyeame Kwame ft Edem",
        "albumName": "Album",
        "categoryId": 202,
        "toneIdStreamingUrl": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=ztYGqnOEdEc=",
        "toneIdpreviewImageUrl": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=ztYGqnOEdEc="
      }
    ]
  }
}
""";
