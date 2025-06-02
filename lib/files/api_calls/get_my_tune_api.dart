import 'dart:convert';

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

Future<MyTunesModel> getMyTuneScApi({int pageNo = 0}) async {
  
   Map<String, dynamic> jsonData = {
     "transactionId": getTransactionId(), //4564336682,
    "featureId": 1,
    "msisdn": StoreManager.msisdn, //"9239198010",
    "languageCode":StoreManager.languageCode,
    "channelId": channelId, //2,
    "serviceId":"" 

  };
  Map<String, dynamic> map = await NetworkManager().post(myTunesScUrl,
      jsonData:
          jsonData); //mockyapi:'https://run.mocky.io/v3/3c30486a-4291-4667-b575-ce6a66e3105b'
  return myTunesModelFromJson(json.encode(map));
 

}
