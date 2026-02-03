import 'package:mtn_ghana_wp/files/model/get_top_leader_board_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<GetLeaderBoardModel> getTopLeaderBoardApi() async {
  String url = getTopLeaderBoardUrl;
  //return getLeaderBoardModelFromJson(_jsonResp);
  Map<String, dynamic> reps =
      await NetworkManager().get(getTopLeaderBoardUrl, addInHeader: [
    {'transactionId': getTransactionId()}
  ]);
  GetLeaderBoardModel model = GetLeaderBoardModel.fromJson(reps);
  return model;
}

String _jsonResp = """{
  "respCode": 0,
  "message": "successful",
  "pointsList": [
    {
      "msisdn": "98****52",
      "rewardPoints": 100,
      "rank": 1
    },
    {
      "msisdn": "98****32",
      "rewardPoints": 50,
      "rank": 2
    }
  ]
}""";

String _jsonResp1 = """{
  "respCode": 0,
  "message": "successful",
  "pointsList": [
    
  ]
}""";
