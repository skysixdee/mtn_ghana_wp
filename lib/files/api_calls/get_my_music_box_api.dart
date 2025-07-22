import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/my_music_box_model.dart';
import 'package:mtn_ghana_wp/files/model/my_tunes_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<MyTunesModel> getMyMusicBoxApi({int pageNo = 0}) async {
  Map<String, dynamic> jsonMap = {
    "transactionId": getTransactionId(),
    "featureId": "1",
    "msisdn": StoreManager.msisdn,
    "languageCode": StoreManager.languageSort,
    "channelId": channelId,
    "serviceId": "MUSICBOX"
  };

  Map<String, dynamic> map =
      await NetworkManager().post(myMusicBoxUrl, jsonData: jsonMap);

  return myTunesModelFromJson(json.encode(map));
  // final ls = myMusicBoxModelFromJson(_jsonString);

  // print("l=========${ls.tonelist?.length}");
  // return ls;
}

String _jsonString = """{
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
            "chargedDate": "2025-07-16 07:50:11",
            "contentId": "8927",
            "contentPreviewImageURL": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=MCDRXooJz7Q=",
            "contentStreamingURL": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=MCDRXooJz7Q=",
            "expiryDate": "2025-09-14 07:50:11",
            "firstActivationDate": "2025-07-16 07:49:58",
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
        }
    ]
}""";
