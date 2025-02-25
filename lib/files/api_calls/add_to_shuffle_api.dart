import 'package:mtn_ghana_wp/files/model/generic_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<GenericModel> addToShuffleApi(String toneId) async {
  String url = addToneToShuffleUrl;
  List<Map<String, dynamic>> toneIdList = [
    {"toneId": toneId}
  ];
  Map<String, dynamic> data = {
    "clientTxnId": getTransactionId(),
    "aPartyMsisdn": StoreManager.msisdn,
    "toneIdList": toneIdList,
    "language": StoreManager.languageCode,
    "activityId": "1",
    "priority": "0",
    "serviceId": "1",
    "channelId": channelId
  };
  Map<String, dynamic> jsonResp =
      await NetworkManager().post(url, formData: data);
  GenericModel model = GenericModel.fromJson(jsonResp);
  return model;
}
