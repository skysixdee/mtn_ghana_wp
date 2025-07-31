import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/list_setting_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<ListSettingModel> listSettingApi() async {
  Map<String, dynamic> jsonMap = {
    "transactionId": getTransactionId(),
    "featureId": 1,
    "msisdn": StoreManager.msisdn, //
    // "msisdn": "95000062",
    // "offerCode": "CRBT_WEEKLY",
    "serviceId": "1",
    "languageCode": StoreManager.languageSort,
    "channelId": channelId
  };

  //{"serviceId":"1"}
  // listSettingUrl =
  //     'http://10.0.10.33:8082/selfcare/subscriber-management/list-settings';

  Map<String, dynamic> jsonResp =
      await NetworkManager().post(listSettingUrl, jsonData: jsonMap);
  return listSettingModelFromJson(json.encode(jsonResp));

  // await Future.delayed(const Duration(seconds: 1));
  // return listSettingModelFromJson(_json1);
}

String _json = """{
    "respCode": 0,
    "message": "successful",
    "settingsList": [
        {
            "contentId": "",
            "defaultToneSelectionType": "ALL",
            "isServiceSuspended": "FALSE",
            "isShuffleOn": "TRUE",
            "lastPurchasedContent": "8932",
            "serviceId": "0",
            "serviceName": "DefaultSettings",
            "timeInfo": "0"
        },
        {
            "activationChannel": "WEB",
            "albumName": "&#78;&#85;&#76;&#76;",
            "albumName_L2": "",
            "artistName": "&#75;&#87;&#65;&#78;&#32;&#80;&#65;",
            "artistName_L2": "",
            "contentId": "0001702",
            "contentName": "&#77;&#97;&#32;&#119;&#97;&#110;&#105;&#32;&#110;&#103;&#121;&#101;",
            "contentName_L2": "",
            "contentPreviewImageURL": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=T9lYldAf35U=",
            "contentStreamingURL": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=T9lYldAf35U=",
            "contentType": "1",
            "expiryDate": "2025-08-29 06:49:55",
            "firstActivationDate": "2025-07-22 10:50:44",
            "isContentPackage": "0",
            "isEnabled": "TRUE",
            "isToneInShuffle": "TRUE",
            "price": "0.5",
            "serviceId": "1",
            "serviceName": "AllCaller",
            "settingsId": "63",
            "status": "A",
            "timeInfo": "0"
        },
        {
            "activationChannel": "IVR",
            "albumName": "&#65;&#108;&#98;&#117;&#109;",
            "albumName_L2": "",
            "artistName": "&#66;&#101;&#116;&#104;&#101;&#108;&#32;&#87;&#111;&#114;&#115;&#104;&#105;&#112;",
            "artistName_L2": "",
            "contentId": "7593411",
            "contentName": "&#84;&#104;&#101;&#32;&#76;&#111;&#114;&#100;&#115;&#32;&#109;&#121;&#32;&#83;&#104;&#101;&#112;&#104;&#101;&#114;&#100;",
            "contentName_L2": "",
            "contentPreviewImageURL": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=z1NjQeYfY3M=",
            "contentStreamingURL": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=z1NjQeYfY3M=",
            "contentType": "1",
            "expiryDate": "2025-08-29 08:59:29",
            "firstActivationDate": "2025-07-21 07:58:11",
            "isContentPackage": "0",
            "isEnabled": "TRUE",
            "isToneInShuffle": "TRUE",
            "price": "0.5",
            "serviceId": "1",
            "serviceName": "AllCaller",
            "settingsId": "67",
            "status": "A",
            "timeInfo": "0"
        },
        {
            "activationChannel": "WEB",
            "contentId": "8926",
            "contentPreviewImageURL": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=+u3WTWq+7a0=",
            "contentStreamingURL": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=+u3WTWq+7a0=",
            "contentType": "1",
            "expiryDate": "2025-09-28 06:50:13",
            "firstActivationDate": "2025-07-16 07:48:37",
            "isContentPackage": "1",
            "isEnabled": "TRUE",
            "isToneInShuffle": "TRUE",
            "price": "0.75",
            "serviceId": "1",
            "serviceName": "AllCaller",
            "settingsId": "64",
            "status": "A",
            "timeInfo": "0"
        },
        {
            "activationChannel": "WEB",
            "contentId": "8928",
            "contentPreviewImageURL": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=SXHqgjJVkuI=",
            "contentStreamingURL": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=SXHqgjJVkuI=",
            "contentType": "1",
            "expiryDate": "2025-09-28 07:04:05",
            "firstActivationDate": "2025-07-16 10:40:34",
            "isContentPackage": "1",
            "isEnabled": "TRUE",
            "isToneInShuffle": "TRUE",
            "price": "0.75",
            "serviceId": "1",
            "serviceName": "AllCaller",
            "settingsId": "66",
            "status": "A",
            "timeInfo": "0"
        },
        {
            "activationChannel": "WEB",
            "contentId": "8931",
            "contentPreviewImageURL": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=i+YAY9e/NbE=",
            "contentStreamingURL": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=i+YAY9e/NbE=",
            "contentType": "1",
            "expiryDate": "2025-09-27 06:55:00",
            "firstActivationDate": "2025-07-22 18:34:43",
            "isContentPackage": "1",
            "isEnabled": "TRUE",
            "isToneInShuffle": "TRUE",
            "price": "0.75",
            "serviceId": "1",
            "serviceName": "AllCaller",
            "settingsId": "65",
            "status": "A",
            "timeInfo": "0"
        },
        {
            "activationChannel": "WEB",
            "contentId": "8932",
            "contentPreviewImageURL": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=orjJEYrkHfI=",
            "contentStreamingURL": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=orjJEYrkHfI=",
            "contentType": "1",
            "expiryDate": "2025-09-28 10:10:04",
            "firstActivationDate": "2025-07-16 07:55:21",
            "isContentPackage": "1",
            "isEnabled": "TRUE",
            "isToneInShuffle": "TRUE",
            "price": "0.75",
            "serviceId": "1",
            "serviceName": "AllCaller",
            "settingsId": "68",
            "status": "A",
            "timeInfo": "0"
        },
        {
            "activationChannel": "WEB",
            "albumName": "&#84;&#72;&#69;&#32;&#68;&#79;&#73;&#78;&#71;&#32;&#79;&#70;&#32;&#84;&#72;&#69;&#32;&#76;&#79;&#82;&#68;",
            "albumName_L2": "",
            "artistName": "&#68;&#73;&#65;&#78;&#65;&#32;&#72;&#65;&#77;&#73;&#76;&#84;&#79;&#78;",
            "artistName_L2": "",
            "contentId": "9941658",
            "contentName": "&#84;&#72;&#69;&#32;&#68;&#79;&#73;&#78;&#71;&#32;&#79;&#70;&#32;&#84;&#72;&#69;&#32;&#76;&#79;&#82;&#68;",
            "contentName_L2": "",
            "contentPreviewImageURL": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=6U2SsraIhFE=",
            "contentStreamingURL": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=6U2SsraIhFE=",
            "contentType": "1",
            "expiryDate": "2025-07-27 06:47:57",
            "firstActivationDate": "2025-07-24 06:47:59",
            "isContentPackage": "0",
            "isEnabled": "TRUE",
            "isToneInShuffle": "FALSE",
            "price": "0",
            "serviceId": "1",
            "serviceName": "AllCaller",
            "settingsId": "49",
            "status": "D",
            "timeInfo": "0"
        }
    ]
}""";
