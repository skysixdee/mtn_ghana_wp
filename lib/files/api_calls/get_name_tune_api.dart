import 'dart:convert';

import 'package:etisalat/files/model/name_tune_model.dart';
import 'package:etisalat/files/network_manager/network_manager.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/constants.dart';
import 'package:etisalat/files/utility/urls.dart';

Future<NameTuneModel> getNameTuneApi({int pageNo = 0}) async {
  String url =
      '${nameTuneUrl}language=${StoreManager.language}&categoryId=115&pageNo=$pageNo&perPageCount=$pagePerCount&searchLanguage=${StoreManager.language}';
  Map<String, dynamic> map = await NetworkManager().get(url);
  return nameTuneModelFromJson(json.encode(map));
}
