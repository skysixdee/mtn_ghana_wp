import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/music_box_content_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<MusicBoxContentModel> getMusicBoxContentApi(String id,
    {int pageNo = 0}) async {
  Map<String, dynamic> jsonData = {
    "transactionId": getTransactionId(), //4564336682,
    "languageCode": StoreManager.languageSort,
    "musicBoxId": id
  };
  Map<String, dynamic> map =
      await NetworkManager().post(getMusicBoxToneListUrl, jsonData: jsonData);
  return musicBoxContentModelFromJson(json.encode(map));
}
