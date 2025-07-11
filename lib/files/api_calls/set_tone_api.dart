import 'dart:convert';

import 'package:mtn_ghana_wp/files/api_calls/get_pack_detail_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_tone_price_api.dart';
import 'package:mtn_ghana_wp/files/model/buy_tone_model.dart';
import 'package:mtn_ghana_wp/files/model/generic_model.dart';
import 'package:mtn_ghana_wp/files/model/get_tone_price_model.dart';
import 'package:mtn_ghana_wp/files/model/pack_detail_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<BuyToneModel> setToneApi(String toneId, String toneName,
    {String? packName}) async {
  String packN = packName ?? await _getPackName(toneId);
  Map<String, dynamic> jsomData = {
    'transactionId': getTransactionId(),
    "featureId": 1,
    'msisdn': StoreManager.msisdn,
    "offerCode": packN,
    'contentId': toneId,
    "contentType": 1,
    'languageCode': StoreManager.languageSort,
    'channelId': channelId,
    'userData': "some data",
    'referralId': '',
  };
  Map<String, dynamic> jsonResp =
      await NetworkManager().post(setToneUrl, formData: jsomData);
  return buyToneModelFromJson(
      json.encode(jsonResp)); //genericModelFromJson(json.encode(jsonResp));
}

Future<String> _getPackName(String toneId) async {
  String packName = '';
  GetTonePriceModel getTonePriceModel = await getTonePriceScApi(toneId);
  print('SKY Price is $getTonePriceModel');
  if (getTonePriceModel.respCode == 0) {
    packName = getTonePriceModel.contentDetails?.offerName ?? '';
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
