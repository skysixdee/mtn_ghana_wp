import 'dart:convert';

import 'package:etisalat/files/model/fetured_model.dart';
import 'package:etisalat/files/network_manager/network_manager.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:etisalat/files/utility/get_transaction_id.dart';
import 'package:etisalat/files/utility/urls.dart';

Future<FeturedModel> getFeaturedListApi(String identifier,
    {String pageNo = "0"}) async {
  String lang = StomreManager.language;
  String msisdn = StomreManager.msisdn;
  int tId = getTransactionId();

  String url =
      "${featuredUrl}language=$lang&msisdn=$msisdn&clientTxnId=$tId&identifier=$identifier&pageNo=$pageNo&perPageCount=$pagePerCount";
  Map<String, dynamic> map = await NetworkManager().get(url);
  return feturedModelFromJson(json.encode(map));
}
