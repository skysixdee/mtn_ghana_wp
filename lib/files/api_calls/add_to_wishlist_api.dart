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
    "msisdn": StoreManager.msisdn,
    "contentId": info.toneId,
    "contentPath": info.toneIdStreamingUrl,
    "previewImage": info.toneIdpreviewImageUrl,
    "contentName_L1": info.toneName,
    "album_L1": info.albumName,
    "artist_L1": info.artistName,
    "contentName_L2": info.toneName,
    "album_L2": info.albumName,
    "artist_L2": info.artistName,
    "price": info.price,
    "languageCode": StoreManager.languageSort,
    "type": 1,
  };
  Map<String, dynamic> result =
      await NetworkManager().post(addToWishlistUrl, jsonData: map);
  GenericModel model = genericModelFromJson(json.encode(result));
  if (model.respCode == 0) {
    String mess = "${info.toneName} is " + "${model.message}";
    snackBar(mess);
  } else {
    snackBar(model.message);
  }
  return;
}
