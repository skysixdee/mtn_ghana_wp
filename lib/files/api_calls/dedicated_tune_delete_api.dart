import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/generic_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<GenericModel> dedicatedTuneDeleteApi(
    String bParty, String toneId, String timeType) async {
  Map<String, dynamic> jsomForm = {
    "aPartyMsisdn": StoreManager.msisdn,
    "bPartyMsisdn": bParty,
    "timeType": timeType,
    "toneId": toneId,
    "language": StoreManager.languageCode,
  };
  Map<String, dynamic> map =
      await NetworkManager().post(deleteDedicatedTuneUrl, formData: jsomForm);
  return genericModelFromJson(json.encode(map));
}
