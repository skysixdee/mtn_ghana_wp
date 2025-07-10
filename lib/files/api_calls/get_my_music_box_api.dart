import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/my_music_box_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<MyMusicBoxModel> getMyMusicBoxApi({int pageNo = 0}) async {
  Map<String, dynamic> jsonMap = {
    "transactionId": getTransactionId(),
    "featureId": "1",
    "msisdn": StoreManager.msisdn,
    "languageCode": StoreManager.languageSort,
    "channelId": channelId,
    "serviceId": "1"
  };

  Map<String, dynamic> map =
      await NetworkManager().post(playingTuneUrl, jsonData: jsonMap);

  return myMusicBoxModelFromJson(json.encode(map));
}
