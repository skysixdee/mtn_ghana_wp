import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/music_box_model.dart';
import 'package:mtn_ghana_wp/files/model/my_tunes_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<MyTunesModel> getMyTuneApi({int pageNo = 0}) async {
  String lag = StoreManager.selectedLanguage;
  String msisdn = StoreManager.msisdn;

  String url =
      "$myTunesUrl?language=$lag&msisdn=$msisdn&startIndex=$pageNo&endIndex=$pagePerCount&rbtMode=400";
  Map<String, dynamic> map = await NetworkManager().get(url);
  return myTunesModelFromJson(json.encode(map));
}

Future<MusicBoxModel> getMyTuneScApi({int pageNo = 0}) async {
  
   Map<String, dynamic> jsonData = {
     "transactionId": getTransactionId(), //4564336682,
    "featureId": 1,
    "msisdn": StoreManager.msisdn, //"9239198010",
    "languageCode":StoreManager.languageCode,
    "channelId": 2,//channelId, 
    "serviceId":"musicbox" 

  };
  Map<String, dynamic> map = await NetworkManager().post(
    "http://10.0.10.33:8082/selfcare/subscriber-management/list-tones",
    //myTunesScUrl,
      jsonData:
          jsonData); //mockyapi:'https://run.mocky.io/v3/3c30486a-4291-4667-b575-ce6a66e3105b'
  return musicBoxModelFromJson(json.encode(map));

}
