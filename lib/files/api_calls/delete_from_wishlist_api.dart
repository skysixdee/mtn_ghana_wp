import 'dart:convert';

import 'package:etisalat/files/model/generic_model.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:etisalat/files/network_manager/network_manager.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/files/utility/get_transaction_id.dart';
import 'package:etisalat/files/utility/urls.dart';

Future<GenericModel> deleteFromWishlistApi(TuneInfo info) async {
  Map<String, dynamic> map = {
    "identifier": "DeleteFromWishList",
    "msisdn": StoreManager.msisdn,
    "catagoryId": "${info.id}",
    "language": "English",
    "clientTxnId": getTransactionId(),
    "wishlistType": "1",
  };
  Map<String, dynamic> mapJso =
      await NetworkManager().post(deleteFromWishlistUrl, formData: map);
  return genericModelFromJson(json.encode(mapJso));
}
