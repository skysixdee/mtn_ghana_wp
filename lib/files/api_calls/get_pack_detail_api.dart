import 'dart:convert';

import 'package:etisalat/files/model/pack_detail_model.dart';
import 'package:etisalat/files/network_manager/network_manager.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/urls.dart';

Future<PackDetailModel> getPackDetailApi() async {
  String url =
      "${packDetailUrl}msisdn=${StoreManager.msisdn}&language=${StoreManager.language}";
  Map<String, dynamic> map = await NetworkManager().get(url);
  return packDetailModelFromJson(json.encode(map));
}
