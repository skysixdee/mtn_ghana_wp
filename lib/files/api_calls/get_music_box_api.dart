import 'dart:convert';
import 'package:mtn_ghana_wp/files/model/music_box_mw_model.dart';
import 'package:mtn_ghana_wp/files/model/music_box_sc_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<MusicBoxMwModel> getMusicBoxApi({int pageNo = 0}) async {
  String url =
      "https://mytune.atom.com.mm/apigw/Middleware/api/adapter/v1/crbt/music-box-search?language=English&pageNo=0&perPageCount=20&type=MB";
      //'${musicBoxUrl}language=${StoreManager.selectedLanguage}&pageNo=$pageNo&perPageCount=$pagePerCount&type=MB';
  Map<String, dynamic> map = await NetworkManager().get(url);
  return musicBoxModelMwFromJson(json.encode(map));
}

Future<MusicBoxScModel> getMusicBoxScApi({int pageNo = 0}) async {
  
   Map<String, dynamic> jsonData = {
     "transactionId": getTransactionId(), //4564336682,
    "featureId": 1,
    "msisdn":StoreManager.msisdn, //"9239198010",
    "languageCode":StoreManager.languageSort,
    "channelId": 2,//channelId, 
    "serviceId":"musicbox" 
  };
  Map<String, dynamic> map = await NetworkManager().post(
    //"http://10.0.10.33:8082/selfcare/subscriber-management/list-tones",
    getMusicBoxScUrl,
      jsonData:jsonData); //mockyapi:'https://run.mocky.io/v3/3c30486a-4291-4667-b575-ce6a66e3105b'
  return musicBoxModelScFromJson(json.encode(map));

}