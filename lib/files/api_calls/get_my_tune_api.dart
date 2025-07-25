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
  // await Future.delayed(Duration(seconds: 2));
  // return myTunesModelFromJson(_finalJson);
}

String _finalJson = """{
    "respCode": 0,
    "message": "successful",
    "responseMap": {
        "toneList": [
            {
                "activationChannel": "WEB",
                "albumName": "&#78;&#85;&#76;&#76;",
                "albumName_L2": "",
                "artistName": "&#75;&#87;&#65;&#78;&#32;&#80;&#65;",
                "artistName_L2": "",
                "chargedDate": "2025-07-22 10:51:02",
                "contentId": "0001702",
                "contentName": "&#77;&#97;&#32;&#119;&#97;&#110;&#105;&#32;&#110;&#103;&#121;&#101;",
                "contentName_L2": "",
                "contentPreviewImageURL": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=T9lYldAf35U=",
                "contentStreamingURL": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=T9lYldAf35U=",
                "contentType": "1",
                "expiryDate": "2025-08-21 10:51:02",
                "firstActivationDate": "2025-07-22 10:50:44",
                "isContentPackage": "0",
                "languageCode": "en",
                "price": "0.5",
                "status": "A"
            },
            {
                "activationChannel": "WEB",
                "albumName": "&#65;&#108;&#98;&#117;&#109;",
                "albumName_L2": "",
                "artistName": "&#72;&#65;&#78;&#78;&#65;&#72;&#32;&#77;&#65;&#82;&#70;&#79;",
                "artistName_L2": "",
                "chargedDate": "2025-07-23 07:12:47",
                "contentId": "1873464",
                "contentName": "&#80;&#65;&#80;&#65;&#32;&#77;&#85;&#79;&#32;&#66;&#79;&#78;&#69;&#32;&#77;&#85;&#79;",
                "contentName_L2": "",
                "contentPreviewImageURL": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=oCw+mXvIA8s=",
                "contentStreamingURL": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=oCw+mXvIA8s=",
                "contentType": "1",
                "expiryDate": "2025-08-07 07:12:46",
                "firstActivationDate": "2025-07-23 07:12:47",
                "isContentPackage": "0",
                "languageCode": "en",
                "price": "0.3",
                "status": "A"
            },
            {
                "activationChannel": "WEB",
                "albumName": "&#65;&#108;&#98;&#117;&#109;",
                "albumName_L2": "",
                "artistName": "&#66;&#101;&#116;&#104;&#101;&#108;&#32;&#87;&#111;&#114;&#115;&#104;&#105;&#112;",
                "artistName_L2": "",
                "chargedDate": "2025-07-22 10:11:56",
                "contentId": "7593411",
                "contentName": "&#84;&#104;&#101;&#32;&#76;&#111;&#114;&#100;&#115;&#32;&#109;&#121;&#32;&#83;&#104;&#101;&#112;&#104;&#101;&#114;&#100;",
                "contentName_L2": "",
                "contentPreviewImageURL": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=z1NjQeYfY3M=",
                "contentStreamingURL": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=z1NjQeYfY3M=",
                "contentType": "1",
                "expiryDate": "2025-08-21 10:11:55",
                "firstActivationDate": "2025-07-21 07:58:11",
                "isContentPackage": "0",
                "languageCode": "en",
                "price": "0.5",
                "status": "A"
            },
            {
                "activationChannel": "WEB",
                "chargedDate": "2025-07-22 10:13:11",
                "contentId": "8926",
                "contentName": "",
                "contentPreviewImageURL": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=+u3WTWq+7a0=",
                "contentStreamingURL": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=+u3WTWq+7a0=",
                "contentType": "1",
                "expiryDate": "2025-09-20 10:13:10",
                "firstActivationDate": "2025-07-16 07:48:37",
                "isContentPackage": "1",
                "languageCode": "en",
                "price": "0.75",
                "status": "A"
            },
            {
                "activationChannel": "USSD",
                "chargedDate": "2025-07-22 10:13:11",
                "contentId": "8931",
                "contentName": "",
                "contentPreviewImageURL": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=i+YAY9e/NbE=",
                "contentStreamingURL": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=i+YAY9e/NbE=",
                "contentType": "1",
                "expiryDate": "2025-07-25 18:35:00",
                "firstActivationDate": "2025-07-22 18:34:43",
                "isContentPackage": "1",
                "languageCode": "en",
                "price": "0",
                "status": "G"
            },
            {
                "activationChannel": "WEB",
                "albumName": "&#84;&#72;&#69;&#32;&#68;&#79;&#73;&#78;&#71;&#32;&#79;&#70;&#32;&#84;&#72;&#69;&#32;&#76;&#79;&#82;&#68;",
                "albumName_L2": "",
                "artistName": "&#68;&#73;&#65;&#78;&#65;&#32;&#72;&#65;&#77;&#73;&#76;&#84;&#79;&#78;",
                "artistName_L2": "",
                "chargedDate": "2025-07-22 10:13:11",
                "contentId": "9941658",
                "contentName": "&#84;&#72;&#69;&#32;&#68;&#79;&#73;&#78;&#71;&#32;&#79;&#70;&#32;&#84;&#72;&#69;&#32;&#76;&#79;&#82;&#68;",
                "contentName_L2": "",
                "contentPreviewImageURL": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=6U2SsraIhFE=",
                "contentStreamingURL": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=6U2SsraIhFE=",
                "contentType": "1",
                "expiryDate": "2025-07-27 06:47:57",
                "firstActivationDate": "2025-07-24 06:47:59",
                "isContentPackage": "0",
                "languageCode": "en",
                "price": "0",
                "status": "G"
            },
            {
                "activationChannel": "WEB",
                "albumName": "&#83;&#69;&#76;&#70;&#45;&#77;&#65;&#68;&#69;",
                "albumName_L2": "",
                "artistName": "&#67;&#65;&#66;&#85;&#77;",
                "artistName_L2": "",
                "chargedDate": "2025-07-22 10:13:11",
                "contentId": "9942315",
                "contentName": "&#66;&#105;&#108;&#108;&#105;&#111;&#110;&#32;&#68;&#111;&#108;&#108;&#97;&#114;&#32;&#77;&#97;&#110;",
                "contentName_L2": "",
                "contentPreviewImageURL": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=9vfwKFPAMSY=",
                "contentStreamingURL": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=9vfwKFPAMSY=",
                "contentType": "1",
                "expiryDate": "2025-07-26 17:01:59",
                "firstActivationDate": "2025-07-23 17:01:59",
                "isContentPackage": "0",
                "languageCode": "en",
                "price": "0",
                "status": "G"
            }
        ]
    }
}""";

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
