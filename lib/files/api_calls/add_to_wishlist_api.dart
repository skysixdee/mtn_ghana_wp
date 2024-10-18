import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/generic_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/snack_bar.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<void> addToWishlistApi(TuneInfo info) async {
  Map<String, dynamic> map = {
    "identifier": "AddToWishList",
    "msisdn": StoreManager.msisdn,
    "contentId": info.toneId,
    "contentName": info.toneName,
    "path": info.toneIdpreviewImageUrl,
    "previewImage": info.toneIdpreviewImageUrl,
    "album": info.albumName,
    "artist": info.artistName,
    "price": info.price,
    "language": StoreManager.language,
    "wishlistType": "1",
  };
  Map<String, dynamic> result =
      await NetworkManager().post(addToWishlistUrl, formData: map);
  GenericModel model = genericModelFromJson(json.encode(result));
  if (model.statusCode == 'SC0000') {
    String mess = "${info.toneName} is " + "${model.message}";
    snackBar(mess);
  } else {
    snackBar(model.message);
  }
  return;
}
