import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/generic_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<GenericModel> deleteFromWishlistApi(TuneInfo info) async {
  Map<String, dynamic> map = {
    "msisdn": StoreManager.msisdn,
    "contentId": "${info.id}",
    "identifier": "DeleteFromWishList",
    "languageCode": StoreManager.languageCode,
    "type": "1",
  };
  Map<String, dynamic> mapJso =
      await NetworkManager().post(deleteFromWishlistUrl, jsonData: map);
  return genericModelFromJson(json.encode(mapJso));
}

// Future<GenericModel> deleteFromWishlistScApi(TuneInfo info) async {
//   Map<String, dynamic> map = {
//     "msisdn": StoreManager.msisdn,
//     "contentId": "${info.id}",
//     "languageCode": "English",
//     "clientTxnId": getTransactionId(),
//     "wishlistType": "1",
//   };
//   Map<String, dynamic> mapJso =
//       await NetworkManager().post(deleteFromWishlistUrl, formData: map);
//   return genericModelFromJson(json.encode(mapJso));
// }
