import 'package:mtn_ghana_wp/files/model/get_reward_point_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<GetRewardPointModel> getRewardPointApi() async {
  return getRewardPointModelFromJson(_sjon);
  Map<String, dynamic> jsonResp = await NetworkManager()
      .post(getRewardPointsUrl, jsonData: {
    'transactionId': getTransactionId(),
    'msisdn': StoreManager.msisdn
  });
  GetRewardPointModel model = GetRewardPointModel.fromJson(jsonResp);
  return model;
}

String _sjon = """{
"respCode": 0,
"message": "successful",
"rewardPoints": 0,
"lastUpdated": "2020-11-08 10:23:27"
}""";
