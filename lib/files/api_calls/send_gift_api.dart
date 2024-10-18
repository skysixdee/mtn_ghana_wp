import 'dart:convert';

import 'package:mtn_ghana_wp/files/api_calls/get_pack_detail_api.dart';
import 'package:mtn_ghana_wp/files/model/generic_model.dart';
import 'package:mtn_ghana_wp/files/model/pack_detail_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<GenericModel> sendGiftfApi(
    String bPartyMsisdn, String toneId, String toneName) async {
  String packName = await _getPackName();
  Map<String, dynamic> jsonData = {
    'msisdnA': StoreManager.msisdn,
    'msisdnB': bPartyMsisdn,
    'toneId': toneId,
    'channel': channelId,
    'username': StoreManager.msisdn,
    'language': StoreManager.languageCode,
    'packName': packName,
    'toneName': toneName
  };
  Map<String, dynamic> jsonResp =
      await NetworkManager().post(sendGiftUrl, formData: jsonData);
  return genericModelFromJson(json.encode(jsonResp));
}

Future<String> _getPackName() async {
  PackDetailModel packDetailModel = await getPackDetailApi();
  if (packDetailModel.statusCode == 'SC0000') {
    return packDetailModel.responseMap?.packStatusDetails?.packName ?? '';
  } else {
    return '';
  }
}
