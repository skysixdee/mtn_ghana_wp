import 'dart:convert';

import 'package:etisalat/files/model/subscriber_validation_model.dart';
import 'package:etisalat/files/network_manager/network_manager.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/get_transaction_id.dart';
import 'package:etisalat/files/utility/urls.dart';
import 'package:flutter/material.dart';

Future<SubscriberValidationModel> generateOtpApi(String msisdn) async {
  Map<String, dynamic> jsonResp =
      await NetworkManager().get(generateOtpUrl, addInHeader: [
    {'msisdn': msisdn}
  ]);
  return subscriberValidationModelFromJson(json.encode(jsonResp));
}
