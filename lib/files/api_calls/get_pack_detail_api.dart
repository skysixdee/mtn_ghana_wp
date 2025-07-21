import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/pack_detail_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<PackDetailModel> getPackDetailApi() async {
  String url = getSubscriptionUrl;

  Map<String, dynamic> jsonData = {'msisdn': StoreManager.msisdn};
  Map<String, dynamic> map =
      await NetworkManager().post(url, jsonData: jsonData);
  return packDetailModelFromJson(json.encode(map));

  //return packDetailModelFromJson(_json);
}

String _json = """{
    "msisdn": "531342979",
    "respCode": 0,
    "message": "successful",
    "offers": [
        {
            "offerName":"CRBT_BASE_PACK",
            "offerStatus": "S",
            "expiryDate": "2025-08-20 07:58:26",
            "chargedAmount": "0.70",
            "chargedDate": "2025-07-21 07:58:26",
            "chargedValidity": "30",
            "activationChannel": "WEB",
            "userPreferredLanguage": "en",
            "groupId": "1",
            "firstActivationDate": "2025-07-08 10:10:30",
            "deactivationDate": "2025-07-21 12:30:31",
            "deactivationChannel": "3",
            "offerType": "BASE_PACK",
            "offerMode": "NORMAL",
            "chargeType": "RECURRING",
            "renewalAttemptDate": "",
            "lastTransactionId": "1500000940384239",
            "chargingResultCode": "50"
        },
        {
            "offerName": "CRBT_MUSIC_BOX",
            "offerStatus": "D",
            "expiryDate": "2025-08-20 12:30:44",
            "chargedAmount": "0.00",
            "chargedDate": "2025-07-21 12:30:44",
            "chargedValidity": "30",
            "activationChannel": "SMS",
            "userPreferredLanguage": "en",
            "groupId": "3",
            "firstActivationDate": "2025-07-16 07:48:37",
            "deactivationDate": "2025-07-21 12:30:31",
            "deactivationChannel": "3",
            "offerType": "ADDON",
            "offerMode": "NORMAL",
            "chargeType": "RECURRING",
            "renewalAttemptDate": "",
            "lastTransactionId": "1500000940384239",
            "chargingResultCode": "50"
        },
        {
            "offerName": "CRBT_SALATI",
            "offerStatus": "A",
            "expiryDate": "2025-08-20 12:30:44",
            "chargedAmount": "0.00",
            "chargedDate": "2025-07-21 12:30:44",
            "chargedValidity": "30",
            "activationChannel": "SMS",
            "userPreferredLanguage": "en",
            "groupId": "3",
            "firstActivationDate": "2025-07-16 07:48:37",
            "deactivationDate": "2025-07-21 12:30:31",
            "deactivationChannel": "3",
            "offerType": "ADDON",
            "offerMode": "NORMAL",
            "chargeType": "RECURRING",
            "renewalAttemptDate": "",
            "lastTransactionId": "1500000940384239",
            "chargingResultCode": "50"
        }
    ]
}""";
