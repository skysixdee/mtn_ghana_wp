import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/wishlist_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';
import 'package:flutter/material.dart';

// Future<WishlistModel> getWishlistApi() async {
//   Map<String, dynamic> formData = {
//     "msisdn": StoreManager.msisdn,
//     "language": StoreManager.selectedLanguage,
//     "identifier": "ViewWishListItems",
//     "wishlistType": "1",
//   };
//   Map<String, dynamic> map =
//       await NetworkManager().post(myWishistUrl, formData: formData);
//   return wishlistModelFromJson(json.encode(map));
// }

Future<WishlistModel> getWishlistScApi() async {
  Map<String, dynamic> jsonData = {
    "msisdn": StoreManager.msisdn,
    "type": 1,
    "languageCode": StoreManager.languageCode,
  };
  Map<String, dynamic> map =
      await NetworkManager().post(myWishistScUrl, jsonData: jsonData);
  return wishlistModelFromJson(json.encode(map));
}
