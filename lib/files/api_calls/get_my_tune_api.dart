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

String _finalJson =
    """{ "respCode" : 0, "message" : "successful" ,"responseMap":{ "toneList" :[ {"activationChannel":"WEB","albumName":"&#78;&#85;&#76;&#76;","albumName_L2":"","artistName":"&#75;&#87;&#65;&#78;&#32;&#80;&#65;","artistName_L2":"","chargedDate":"2025-07-30 06:49:55","contentId":"0001702","contentName":"&#77;&#97;&#32;&#119;&#97;&#110;&#105;&#32;&#110;&#103;&#121;&#101;","contentName_L2":"","contentPreviewImageURL":"http://10.135.64.104:8179/stream-media/get-preview-image?fileId=T9lYldAf35U=","contentStreamingURL":"http://10.135.64.104:8179/stream-media/get-tone-path?fileId=T9lYldAf35U=","contentType":"1","expiryDate":"2025-08-29 06:49:55","firstActivationDate":"2025-07-22 10:50:44","isContentPackage":"0","languageCode":"en","price":"0.5","status":"A"},{"activationChannel":"IVR","albumName":"&#65;&#108;&#98;&#117;&#109;","albumName_L2":"","artistName":"&#66;&#101;&#116;&#104;&#101;&#108;&#32;&#87;&#111;&#114;&#115;&#104;&#105;&#112;","artistName_L2":"","chargedDate":"2025-07-30 08:59:29","contentId":"7593411","contentName":"&#84;&#104;&#101;&#32;&#76;&#111;&#114;&#100;&#115;&#32;&#109;&#121;&#32;&#83;&#104;&#101;&#112;&#104;&#101;&#114;&#100;","contentName_L2":"","contentPreviewImageURL":"http://10.135.64.104:8179/stream-media/get-preview-image?fileId=z1NjQeYfY3M=","contentStreamingURL":"http://10.135.64.104:8179/stream-media/get-tone-path?fileId=z1NjQeYfY3M=","contentType":"1","expiryDate":"2025-08-29 08:59:29","firstActivationDate":"2025-07-21 07:58:11","isContentPackage":"0","languageCode":"en","price":"0.5","status":"A"},{"activationChannel":"WEB","chargedDate":"2025-07-30 06:50:13","contentId":"8926","contentName":"","contentPreviewImageURL":"http://10.135.64.104:8179/stream-media/get-preview-image?fileId=+u3WTWq+7a0=","contentStreamingURL":"http://10.135.64.104:8179/stream-media/get-tone-path?fileId=+u3WTWq+7a0=","contentType":"1","expiryDate":"2025-09-28 06:50:13","firstActivationDate":"2025-07-16 07:48:37","isContentPackage":"1","languageCode":"en","price":"0.75","status":"A"},{"activationChannel":"WEB","chargedDate":"2025-07-30 07:04:05","contentId":"8928","contentName":"","contentPreviewImageURL":"http://10.135.64.104:8179/stream-media/get-preview-image?fileId=SXHqgjJVkuI=","contentStreamingURL":"http://10.135.64.104:8179/stream-media/get-tone-path?fileId=SXHqgjJVkuI=","contentType":"1","expiryDate":"2025-09-28 07:04:05","firstActivationDate":"2025-07-16 10:40:34","isContentPackage":"1","languageCode":"en","price":"0.75","status":"A"},{"activationChannel":"WEB","chargedDate":"2025-07-30 06:55:00","contentId":"8931","contentName":"","contentPreviewImageURL":"http://10.135.64.104:8179/stream-media/get-preview-image?fileId=i+YAY9e/NbE=","contentStreamingURL":"http://10.135.64.104:8179/stream-media/get-tone-path?fileId=i+YAY9e/NbE=","contentType":"1","expiryDate":"2025-09-27 06:55:00","firstActivationDate":"2025-07-22 18:34:43","isContentPackage":"1","languageCode":"en","price":"0.75","status":"A"},{"activationChannel":"WEB","chargedDate":"2025-07-30 10:10:05","contentId":"8932","contentName":"","contentPreviewImageURL":"http://10.135.64.104:8179/stream-media/get-preview-image?fileId=orjJEYrkHfI=","contentStreamingURL":"http://10.135.64.104:8179/stream-media/get-tone-path?fileId=orjJEYrkHfI=","contentType":"1","expiryDate":"2025-09-28 10:10:04","firstActivationDate":"2025-07-16 07:55:21","isContentPackage":"1","languageCode":"en","price":"0.75","status":"A"} ]}}""";
