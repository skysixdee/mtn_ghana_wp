import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/category_model.dart';

import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/utility/get_transaction_id.dart';

import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<CategoryModel> getCategoryScApi() async {
  Map<String, int> header = {"transId": getTransactionId()};
  Map<String, dynamic> map =
      await NetworkManager().get(getCategoryListUrl, addInHeader: [header]);
  return categoryModelFromJson(json.encode(map));
  //return categoryModelFromJson(_json);
}

String _json = """{
    "respCode": "SC0000",
    "message": "SUCCESS",
    "responseMap": {
        "categoryList": [
            {
                "language": "English",
                "categoryID": "44",
                "menuID": "15",
                "categoryName": "Hip Hop",
                "menuImage": "https://10.135.64.104:8123/stream-media/get-category-menu-image?menuId=15"
            },
            {
                "language": "English",
                "categoryID": "64",
                "menuID": "13",
                "categoryName": "Hiplife",
                "menuImage": "https://10.135.64.104:8123/stream-media/get-category-menu-image?menuId=13"
            },
            {
                "language": "English",
                "categoryID": "53",
                "menuID": "5",
                "categoryName": "Gospel",
                "menuImage": "https://10.135.64.104:8123/stream-media/get-category-menu-image?menuId=5"
            },
            {
                "language": "English",
                "categoryID": "48",
                "menuID": "7",
                "categoryName": "Pop",
                "menuImage": "https://10.135.64.104:8123/stream-media/get-category-menu-image?menuId=7"
            },
            {
                "language": "English",
                "categoryID": "129",
                "menuID": "9",
                "categoryName": "Rnb",
                "menuImage": "https://10.135.64.104:8123/stream-media/get-category-menu-image?menuId=9"
            },
            {
                "language": "English",
                "categoryID": "60",
                "menuID": "11",
                "categoryName": "Rock",
                "menuImage": "https://10.135.64.104:8123/stream-media/get-category-menu-image?menuId=11"
            },
            {
                "language": "English",
                "categoryID": "52",
                "menuID": "6",
                "categoryName": "Reggae",
                "menuImage": "https://10.135.64.104:8123/stream-media/get-category-menu-image?menuId=6"
            }
        ]
    }
}""";
