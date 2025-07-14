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
  "settingsList": [
    {
      "activationChannel": "USSD",
      "albumName": "PAPAPA",
      "albumName_L2": "",
      "artistName": "KECHE",
      "artistName_L2": "",
      "contentId": "9942293",
      "contentName": "Papapa",
      "contentName_L2": "",
      "contentPreviewImageURL": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=9Rm5pF9/HB8=",
      "contentStreamingURL": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=9Rm5pF9/HB8=",
      "contentType": "1",
      "defaultToneSelectionType": "LASTPURCHASED",
      "expiryDate": "2025-08-10 17:42:31",
      "firstActivationDate": "2025-07-11 17:42:23",
      "isContentPackage": "0",
      "isServiceSuspended": "FALSE",
      "isShuffleOn": "FALSE",
      "price": "0.5",
      "serviceId": "0",
      "serviceName": "DefaultSettings",
      "status": "D"
    },
    {
      "activationChannel": "USSD",
      "albumName": "Album",
      "albumName_L2": "",
      "artistName": "Africaaba",
      "artistName_L2": "",
      "contentId": "5543411",
      "contentName": "Abena Tuesday",
      "contentName_L2": "",
      "contentPreviewImageURL": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=+lh1+aCqKYI=",
      "contentStreamingURL": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=+lh1+aCqKYI=",
      "contentType": "1",
      "expiryDate": "2025-08-13 10:42:41",
      "firstActivationDate": "2025-07-14 10:42:31",
      "isContentPackage": "0",
      "isToneInShuffle": "TRUE",
      "price": "0.5",
      "serviceId": "1",
      "serviceName": "AllCaller",
      "settingsId": "15242",
      "status": "A"
    },
    {
      "activationChannel": "WEB",
      "albumName": "ENNWAI",
      "albumName_L2": "",
      "artistName": "ENNWAI",
      "artistName_L2": "",
      "contentId": "9942230",
      "contentName": "Always busy",
      "contentName_L2": "",
      "contentPreviewImageURL": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=j0hdZU2pN2o=",
      "contentStreamingURL": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=j0hdZU2pN2o=",
      "contentType": "1",
      "expiryDate": "2025-08-13 10:00:41",
      "firstActivationDate": "2025-07-14 10:00:29",
      "isContentPackage": "0",
      "isToneInShuffle": "TRUE",
      "price": "0.5",
      "serviceId": "1",
      "serviceName": "AllCaller",
      "settingsId": "15241",
      "status": "A"
    },
    {
      "activationChannel": "USSD",
      "albumName": "DID I LIE",
      "albumName_L2": "",
      "artistName": "CINA SOUL",
      "artistName_L2": "",
      "contentId": "9942247",
      "contentName": "Personal",
      "contentName_L2": "",
      "contentPreviewImageURL": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=9Rm5pF9/HB8=",
      "contentStreamingURL": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=9Rm5pF9/HB8=",
      "contentType": "1",
      "expiryDate": "2025-08-10 17:42:31",
      "firstActivationDate": "2025-07-11 17:42:23",
      "isContentPackage": "0",
      "isToneInShuffle": "TRUE",
      "price": "0.5",
      "serviceId": "1",
      "serviceName": "AllCaller",
      "settingsId": "15227",
      "status": "D"
    },
    {
      "activationChannel": "USSD",
      "albumName": "ASEDA",
      "albumName_L2": "",
      "artistName": "BRA ADJEI",
      "artistName_L2": "",
      "contentId": "9942266",
      "contentName": "ONYAME BA",
      "contentName_L2": "",
      "contentPreviewImageURL": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=2YwzcaDToyc=",
      "contentStreamingURL": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=2YwzcaDToyc=",
      "contentType": "1",
      "expiryDate": "2025-08-10 18:39:05",
      "firstActivationDate": "2025-07-11 18:38:57",
      "isContentPackage": "0",
      "isToneInShuffle": "TRUE",
      "price": "0.5",
      "serviceId": "1",
      "serviceName": "AllCaller",
      "settingsId": "15228",
      "status": "D"
    },
    {
      "activationChannel": "USSD",
      "albumName": "ASEDA",
      "albumName_L2": "",
      "artistName": "BRA ADJEI",
      "artistName_L2": "",
      "contentId": "9942268",
      "contentName": "THE BLOOD",
      "contentName_L2": "",
      "contentPreviewImageURL": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=2318INmagZI=",
      "contentStreamingURL": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=2318INmagZI=",
      "contentType": "1",
      "expiryDate": "2025-08-10 18:48:36",
      "firstActivationDate": "2025-07-11 18:48:27",
      "isContentPackage": "0",
      "isToneInShuffle": "TRUE",
      "price": "0.65",
      "serviceId": "1",
      "serviceName": "AllCaller",
      "settingsId": "15229",
      "status": "A"
    },
    {
      "activationChannel": "USSD",
      "albumName": "THE DAWN OF POSSIBILITY",
      "albumName_L2": "",
      "artistName": "PETE MENZ",
      "artistName_L2": "",
      "contentId": "9942288",
      "contentName": "Breaking Rules",
      "contentName_L2": "",
      "contentPreviewImageURL": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=leYsm3i/mWc=",
      "contentStreamingURL": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=leYsm3i/mWc=",
      "contentType": "1",
      "expiryDate": "2025-08-13 08:15:26",
      "firstActivationDate": "2025-07-14 08:15:18",
      "isContentPackage": "0",
      "isToneInShuffle": "TRUE",
      "price": "0.5",
      "serviceId": "1",
      "serviceName": "AllCaller",
      "settingsId": "15240",
      "status": "A"
    },
    {
      "activationChannel": "USSD",
      "albumName": "PAPAPA",
      "albumName_L2": "",
      "artistName": "KECHE",
      "artistName_L2": "",
      "contentId": "9942293",
      "contentName": "Papapa",
      "contentName_L2": "",
      "contentPreviewImageURL": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=bGKUZH0rMmY=",
      "contentStreamingURL": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=bGKUZH0rMmY=",
      "contentType": "1",
      "expiryDate": "2025-08-13 11:48:34",
      "firstActivationDate": "2025-07-14 11:48:24",
      "isContentPackage": "0",
      "isToneInShuffle": "TRUE",
      "price": "0.5",
      "serviceId": "1",
      "serviceName": "AllCaller",
      "settingsId": "15243",
      "status": "A"
    }
  ]
}
""";
