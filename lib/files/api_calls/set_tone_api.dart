import 'dart:convert';

import 'package:etisalat/files/api_calls/get_pack_detail_api.dart';
import 'package:etisalat/files/model/generic_model.dart';
import 'package:etisalat/files/model/pack_detail_model.dart';
import 'package:etisalat/files/network_manager/network_manager.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:etisalat/files/utility/get_transaction_id.dart';
import 'package:etisalat/files/utility/urls.dart';

Future<GenericModel> setToneApi(String toneId, String toneName) async {
  String packName = await _getPackName();
  Map<String, dynamic> jsomData = {
    'clientTxnId': getTransactionId(),
    'language': StoreManager.languageCode,
    'msisdn': StoreManager.msisdn,
    'toneId': toneId,
    'toneName': toneName,
    'packName': packName,
    'username': StoreManager.msisdn,
    'channelId': channelId,
  };
  Map<String, dynamic> jsonResp =
      await NetworkManager().post(setToneUrl, formData: jsomData);
  return genericModelFromJson(json.encode(jsonResp));
}

Future<String> _getPackName() async {
  String packName = '';
  PackDetailModel packDetailModel = await getPackDetailApi();
  if (packDetailModel.statusCode == 'SC0000') {
    packName = packDetailModel.responseMap?.packStatusDetails?.packName ?? '';
    return packName;
  } else {
    return '';
  }
}
