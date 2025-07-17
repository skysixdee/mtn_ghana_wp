import 'dart:convert';
import 'package:mtn_ghana_wp/files/model/my_tunes_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<MyTunesModel> getMyTuneApi({int pageNo = 0}) async {
  Map<String, dynamic> jsonMap = {
    "transactionId": getTransactionId(),
    "featureId": "1",
    "msisdn": StoreManager.msisdn,
    "languageCode": StoreManager.languageSort,
    "channelId": channelId,
    "serviceId": ""

    // "serviceId": "MUSICBOX",
    // "isContentPackage": "1"
  };

  Map<String, dynamic> map =
      await NetworkManager().post(myTunesUrl, jsonData: jsonMap);
  return myTunesModelFromJson(json.encode(map));

  //return myTunesModelFromJson(_json);
}

String _json = """{
    "respCode": 0,
    "message": "successful",
    "tonelist": [
        {
            "ContentType": "1",
            "activationChannel": "WEB",
            "chargedDate": "2025-07-16 07:48:50",
            "contentId": "8926",
            "contentPreviewImageURL": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=+u3WTWq+7a0=",
            "contentStreamingURL": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=+u3WTWq+7a0=",
            "expiryDate": "2025-09-14 07:48:50",
            "firstActivationDate": "2025-07-16 07:48:37",
            "isContentPackage": "1",
            "languageCode": "en",
            "price": "0.75",
            "status": "A"
        },
        {
            "ContentType": "1",
            "activationChannel": "WEB",
            "chargedDate": "2025-07-16 10:40:47",
            "contentId": "8928",
            "contentPreviewImageURL": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=SXHqgjJVkuI=",
            "contentStreamingURL": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=SXHqgjJVkuI=",
            "expiryDate": "2025-09-14 10:40:46",
            "firstActivationDate": "2025-07-16 10:40:34",
            "isContentPackage": "1",
            "languageCode": "en",
            "price": "0.75",
            "status": "A"
        },
        {
            "ContentType": "1",
            "activationChannel": "USSD",
            "chargedDate": "2025-07-16 07:55:34",
            "contentId": "8932",
            "contentPreviewImageURL": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=orjJEYrkHfI=",
            "contentStreamingURL": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=orjJEYrkHfI=",
            "expiryDate": "2025-09-14 07:55:34",
            "firstActivationDate": "2025-07-16 07:55:21",
            "isContentPackage": "1",
            "languageCode": "en",
            "price": "0.75",
            "status": "A"
        },
        {
            "ContentType": "1",
            "activationChannel": "USSD",
            "albumName": "&#69;&#78;&#78;&#87;&#65;&#73;",
            "albumName_L2": "",
            "artistName": "&#69;&#78;&#78;&#87;&#65;&#73;",
            "artistName_L2": "",
            "chargedDate": "2025-07-16 11:48:09",
            "contentId": "9942225",
            "contentName": "&#73;&#109;&#97;&#103;&#105;&#110;&#101;",
            "contentName_L2": "",
            "contentPreviewImageURL": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=33uo/YSEoBI=",
            "contentStreamingURL": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=33uo/YSEoBI=",
            "expiryDate": "2025-08-15 11:48:08",
            "firstActivationDate": "2025-07-16 07:27:39",
            "isContentPackage": "0",
            "languageCode": "en",
            "price": "0.5",
            "status": "A"
        },
        {
            "ContentType": "1",
            "activationChannel": "USSD",
            "albumName": "&#70;&#82;&#69;&#78;&#69;&#77;&#89;",
            "albumName_L2": "",
            "artistName": "&#79;&#76;&#79;&#78;&#75;&#65;",
            "artistName_L2": "",
            "chargedDate": "2025-07-16 11:22:15",
            "contentId": "9942255",
            "contentName": "&#70;&#114;&#101;&#110;&#101;&#109;&#121;",
            "contentName_L2": "",
            "contentPreviewImageURL": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=WKBTgvgaWAA=",
            "contentStreamingURL": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=WKBTgvgaWAA=",
            "expiryDate": "2025-08-15 11:22:15",
            "firstActivationDate": "2025-07-16 11:22:02",
            "isContentPackage": "0",
            "languageCode": "en",
            "price": "0.5",
            "status": "A"
        },
        {
            "ContentType": "1",
            "activationChannel": "USSD",
            "albumName": "&#87;&#65;&#84;&#67;&#72;&#32;&#77;&#69;",
            "albumName_L2": "",
            "artistName": "&#69;&#77;&#80;&#82;&#69;&#83;&#83;&#32;&#71;&#73;&#70;&#84;&#89;",
            "artistName_L2": "",
            "chargedDate": "2025-07-16 11:26:10",
            "contentId": "9942301",
            "contentName": "&#87;&#97;&#116;&#99;&#104;&#32;&#77;&#101;",
            "contentName_L2": "",
            "contentPreviewImageURL": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=BAarLWqKQGA=",
            "contentStreamingURL": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=BAarLWqKQGA=",
            "expiryDate": "2025-08-15 11:26:10",
            "firstActivationDate": "2025-07-16 11:25:57",
            "isContentPackage": "0",
            "languageCode": "en",
            "price": "0.5",
            "status": "A"
        }
    ]
}""";
