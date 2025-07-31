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
  // final ls = myTunesModelFromJson(_finalJson);
  // return ls;
  // print("l=========${ls.tonelist?.length}");
  // return ls;
}

String _finalJson =
    """{ "respCode" : 0, "message" : "successful" ,"responseMap":{ "toneList" :[ {"activationChannel":"WEB","chargedDate":"2025-07-30 06:50:13","contentId":"8926","contentName":"","contentPreviewImageURL":"http://10.135.64.104:8179/stream-media/get-preview-image?fileId=+u3WTWq+7a0=","contentStreamingURL":"http://10.135.64.104:8179/stream-media/get-tone-path?fileId=+u3WTWq+7a0=","contentType":"1","expiryDate":"2025-09-28 06:50:13","firstActivationDate":"2025-07-16 07:48:37","isContentPackage":"1","languageCode":"en","price":"0.75","status":"A"},{"activationChannel":"WEB","chargedDate":"2025-07-30 07:04:05","contentId":"8928","contentName":"","contentPreviewImageURL":"http://10.135.64.104:8179/stream-media/get-preview-image?fileId=SXHqgjJVkuI=","contentStreamingURL":"http://10.135.64.104:8179/stream-media/get-tone-path?fileId=SXHqgjJVkuI=","contentType":"1","expiryDate":"2025-09-28 07:04:05","firstActivationDate":"2025-07-16 10:40:34","isContentPackage":"1","languageCode":"en","price":"0.75","status":"A"},{"activationChannel":"WEB","chargedDate":"2025-07-30 06:55:00","contentId":"8931","contentName":"","contentPreviewImageURL":"http://10.135.64.104:8179/stream-media/get-preview-image?fileId=i+YAY9e/NbE=","contentStreamingURL":"http://10.135.64.104:8179/stream-media/get-tone-path?fileId=i+YAY9e/NbE=","contentType":"1","expiryDate":"2025-09-27 06:55:00","firstActivationDate":"2025-07-22 18:34:43","isContentPackage":"1","languageCode":"en","price":"0.75","status":"A"},{"activationChannel":"WEB","chargedDate":"2025-07-30 10:10:05","contentId":"8932","contentName":"","contentPreviewImageURL":"http://10.135.64.104:8179/stream-media/get-preview-image?fileId=orjJEYrkHfI=","contentStreamingURL":"http://10.135.64.104:8179/stream-media/get-tone-path?fileId=orjJEYrkHfI=","contentType":"1","expiryDate":"2025-09-28 10:10:04","firstActivationDate":"2025-07-16 07:55:21","isContentPackage":"1","languageCode":"en","price":"0.75","status":"A"} ]}}""";
