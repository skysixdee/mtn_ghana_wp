import 'package:mtn_ghana_wp/files/model/get_top_leader_board_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<GetLeaderBoardModel> getTopLeaderBoardApi() async {
  //return getLeaderBoardModelFromJson(_jsonResp);
  String url = "$getTopLeaderBoardUrl?transactionId=${getTransactionId()}";
  Map<String, dynamic> reps = await NetworkManager().get(url);
  GetLeaderBoardModel model = GetLeaderBoardModel.fromJson(reps);
  return model;
}

String _jsonResp = """{
  "respCode": 0,
  "message": "successful",
  "pointsList": [
    {
      "msisdn": "98****52",
      "rewardPoints": "665654",
      "rank": "1"
    },
    {
      "msisdn": "98****32",
      "rewardPoints": "665653",
      "rank": "2"
    },
    {
      "msisdn": "98****52",
      "rewardPoints": "665652",
      "rank": "3"
    }
    
  ]
}""";

String _jsonResp1 = """{
  "respCode": 0,
  "message": "successful",
  "pointsList": [
    
  ]
}""";
