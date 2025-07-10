import 'package:mtn_ghana_wp/files/model/generic_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<GenericModel> addToShuffleScApi(String toneId) async {
  String url = addToneToShuffleScUrl;
  List<Map<String, dynamic>> toneIdList = [
    {"contentId": toneId}
  ];
  Map<String, dynamic> data = {
    "transactionId": getTransactionId(),
    "featureId": 1,
    "msisdn": StoreManager.msisdn,
    "channelId": channelId,
    "contentIdlist": toneIdList
  };
  Map<String, dynamic> jsonResp =
      await NetworkManager().post(url, jsonData: data);
  GenericModel model = GenericModel.fromJson(jsonResp);
  return model;
}
