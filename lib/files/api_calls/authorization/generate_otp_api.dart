import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/subscriber_validation_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<SubscriberValidationModel> generateOtpApi(String msisdn) async {
  Map<String, dynamic> jsonResp =
      await NetworkManager().get(generateOtpUrl, addInHeader: [
    {'msisdn': msisdn}
  ]);
  return subscriberValidationModelFromJson(json.encode(jsonResp));
}
