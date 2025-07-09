import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/music_box_content_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<MusicBoxContentModel> getMusicBoxContentApi(String type, String code,
    {int pageNo = 0}) async {
       Map<String, dynamic> jsonData = {
     "transactionId": getTransactionId(), //4564336682,
    "languageCode":StoreManager.languageSort,
    "musicBoxId":code

  };
  Map<String, dynamic> map = await NetworkManager().post(
   // "http://10.0.10.33:8082/selfcare/subscriber-management/list-tones",
    getMusicBoxToneListUrl,
      jsonData:jsonData); //mockyapi:'https://run.mocky.io/v3/3c30486a-4291-4667-b575-ce6a66e3105b'
 // return musicBoxModelScFromJson(json.encode(map));

  // String url =
  //     '${musicBoxContextUrl}language=${StoreManager.selectedLanguage}&pageNo=$pageNo&perPageCount=$pagePerCount&type=$type&toneCode=$code';
  // Map<String, dynamic> map = await NetworkManager().get(url);
  return musicBoxContentModelFromJson(json.encode(map));
}
