import 'dart:convert';

import 'package:etisalat/files/model/wishlist_model.dart';
import 'package:etisalat/files/network_manager/network_manager.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/urls.dart';
import 'package:flutter/material.dart';

Future<WishlistModel> getWishlistApi() async {
  Map<String, dynamic> formData = {
    "msisdn": StoreManager.msisdn,
    "language": StoreManager.language,
    "identifier": "ViewWishListItems",
    "wishlistType": "1",
  };
  Map<String, dynamic> map =
      await NetworkManager().post(myWishistUrl, formData: formData);
  return wishlistModelFromJson(json.encode(map));
}
