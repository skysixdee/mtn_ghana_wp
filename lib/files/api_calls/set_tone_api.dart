import 'dart:convert';

import 'package:mtn_ghana_wp/files/api_calls/get_pack_detail_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_tone_price_api.dart';
import 'package:mtn_ghana_wp/files/model/generic_model.dart';
import 'package:mtn_ghana_wp/files/model/get_tone_price_model.dart';
import 'package:mtn_ghana_wp/files/model/pack_detail_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<GenericModel> setToneApi(String toneId, String toneName,
    {String? packName}) async {
  String packN = packName ?? await _getPackName(toneId);
  Map<String, dynamic> jsomData = {
    'clientTxnId': getTransactionId(),
    'language': StoreManager.languageCode,
    'msisdn': StoreManager.msisdn,
    'toneId': toneId,
    'toneName': toneName,
    'packName': packN,
    'username': StoreManager.msisdn,
    'channelId': channelId,
  };
  Map<String, dynamic> jsonResp =
      await NetworkManager().post(setToneUrl, formData: jsomData);
  return genericModelFromJson(json.encode(jsonResp));
}

Future<String> _getPackName(String toneId) async {
  String packName = '';
  GetTonePriceModell getTonePriceModel = await getTonePriceScApi(toneId);
  print('SKY Price is $getTonePriceModel');
  if (getTonePriceModel.statusCode == 'SC0000') {
    packName =
        getTonePriceModel.responseMap?.responseDetails?[0].packName ?? '';
    return packName;
  } else {
    return '';
  }
  //PackDetailModel packDetailModel = await getPackDetailApi();
  // if (packDetailModel.statusCode == 'SC0000') {
  //   packName = packDetailModel.responseMap?.packStatusDetails?.packName ?? '';
  //   return packName;
  // } else {
  //   return '';
  // }
}
