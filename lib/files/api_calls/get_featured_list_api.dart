import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/fetured_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<FeturedModel> getFeaturedListApi(String identifier,
    {String pageNo = "0"}) async {
  String lang = StoreManager.language;
  String msisdn = StoreManager.msisdn;
  int tId = getTransactionId();

  String url =
      "${featuredUrl}language=$lang&msisdn=$msisdn&clientTxnId=$tId&identifier=$identifier&pageNo=$pageNo&perPageCount=$pagePerCount";
  Map<String, dynamic> map = await NetworkManager().get(url);
  return feturedModelFromJson(json.encode(map));
}
