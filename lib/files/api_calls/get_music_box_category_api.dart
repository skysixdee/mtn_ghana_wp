import 'package:mtn_ghana_wp/files/model/music_box_content_model.dart';
import 'package:mtn_ghana_wp/files/model/music_box_sc_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<MusicBoxScModel> getMusicBoxCategroyApi(
    {int pageNo = 0, String category = "GOLD"}) async {
  var postData = {
    "transactionId": getTransactionId(),
    "channelId": channelId,
    "perPageCount": "40", //pagePerCount,
    "pageNo": pageNo,
    "type": "MB",
    "tier": category //"GOLD"
  };

  Map<String, dynamic> map =
      await NetworkManager().post(getMusicBoxListUrl, jsonData: postData);
  MusicBoxScModel model = MusicBoxScModel.fromJson(map);
  return model;
}
