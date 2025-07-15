import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/list_setting_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<ListSettingModel> listSettingApi(String packName) async {
  Map<String, dynamic> jsonMap = {
    "transactionId": getTransactionId(),
    "featureId": 1,
    "msisdn": StoreManager.msisdn,
    "offerCode": packName,
    "languageCode": StoreManager.languageSort,
    "channelId": channelId
  };
  //await Future.delayed(const Duration(seconds: 1));
  Map<String, dynamic> jsonResp =
      await NetworkManager().post(listSettingUrl, jsonData: jsonMap);
  return listSettingModelFromJson(json.encode(jsonResp));
  //return listSettingModelFromJson(_json);
}

String _json = """{
  "respCode": 0,
  "message": "successful",
  "settingslist": [
    {
      "serviceId": "0",
      "serviceName": "DefaultSettings",
      "contentId": "NULL",
      "defaultToneSelectionType": "custom",
      "isShuffleOn": "true",
      "isServiceSuspended": "false"
    },
    {
      "serviceId": "2",
      "serviceName": "Dedication",
      "contentId": "3346588",
      "contentName": "Like a Rolling Stone",
      "albumName": "afafaga",
      "artistName": "Bob Dylan",
      "isContentPackage": "0",
      "contentType": "1",
      "contentStreamingURL": "https://funtone.ooredoo.com.mm/stream-media/get-tone-path?fileId=0Shprh9x2cffRp5KT5lW1Q==",
      "contentPreviewImageURL": "https://funtone.ooredoo.com.mm/stream-media/get-preview-image?fileId=0Shprh9x2cffRp5KT5lW1Q==",
      "status": "A",
      "firstActivationDate": "2023-12-13 16:27:57",
      "price": "10.5",
      "activationChannel": 1,
      "expiryDate": "2023-12-20 16:27:57",
      "bMsisdn": "7167179263"
    },
    {
      "serviceId": "1",
      "serviceName": "AllCaller",
      "contentId": "2345567",
      "contentName": "Allahumma Eateq Reqabana",
      "albumName": "afafaga",
      "artistName": "Maher Al Muaiqly",
      "isContentPackage": "0",
      "contentType": "1",
      "contentStreamingURL": "https://funtone.ooredoo.com.mm/stream-media/get-tone-path?fileId=0Shprh9x2cffRp5KT5lW1Q==",
      "contentPreviewImageURL": "https://funtone.ooredoo.com.mm/stream-media/get-preview-image?fileId=0Shprh9x2cffRp5KT5lW1Q==",
      "status": "A",
      "firstActivationDate": "2023-12-13 16:27:57",
      "price": "10.5",
      "activationChannel": 1,
      "expiryDate": "2023-12-20 16:27:57"
    },
    {
      "serviceId": "4",
      "serviceName": "Group",
      "contentId": "3345789",
      "contentName": "What's Going On",
      "albumName": "afafaga",
      "artistName": "Marvin Gaye",
      "isContentPackage": "0",
      "contentType": "1",
      "contentStreamingURL": "https://funtone.ooredoo.com.mm/stream-media/get-tone-path?fileId=0Shprh9x2cffRp5KT5lW1Q==",
      "contentPreviewImageURL": "https://funtone.ooredoo.com.mm/stream-media/get-preview-image?fileId=0Shprh9x2cffRp5KT5lW1Q==",
      "status": "A",
      "firstActivationDate": "2023-12-13 16:27:57",
      "price": "10.5",
      "activationChannel": 1,
      "expiryDate": "2023-12-20 16:27:57",
      "groupId": "7173"
    }
  ]
}
""";
