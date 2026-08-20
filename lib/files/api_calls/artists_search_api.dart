import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/artists_model.dart';
import 'package:mtn_ghana_wp/files/model/search_result_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

Future<ArtistsModel> getArtistListApi(String key, {int pageNo = 0}) async {
  Map<String, dynamic> jsonData = {
    "sortBy": "ContentArtist", //"OrderBy",
    "pageNo": pageNo,
    "perPageCount": pagePerCount,
    "filter":
        "ContentArtist", //key.isEmpty ? "Artist" : "ArtistStartWith", //"Artist",
    "filterPref": "begin",
    "locale": StoreManager.languageSort,
    "searchKey": key.isEmpty
        ? [
            "a",
            "b",
            "c",
            "d",
            "e",
            "f",
            "g",
            "h",
            "i",
            "j",
            "k",
            "l",
            "m",
            "n",
            "o",
            "p",
            "q",
            "r",
            "s",
            "t",
            "u",
            "v",
            "w",
            "x",
            "y",
            "z"
          ]
        : [key]
  };
//https://callertunez.mtn.com.gh/selfcare/artist-web
  String url = artistsSearchNewUrl;
  //"https://callertunez.mtn.com.gh/selfcare/artist-web"; //artistsSearchUrl;

  Map<String, dynamic> map =
      await NetworkManager().post(url, jsonData: jsonData);
  return artistsModelFromJson(json.encode(map));

  await Future.delayed(Duration(seconds: 2));
  return artistsModelFromJson(_json);
}

Future<ArtistsModel> getArtistListNewApi(String key, {int pageNo = 0}) async {
  Map<String, dynamic> jsonData = {
    "sortBy": "OrderBy", // "ContentArtist", //
    "pageNo": pageNo,
    "perPageCount": pagePerCount,
    "filter": "Artist",
    //"ContentArtist", //key.isEmpty ? "Artist" : "ArtistStartWith", //"Artist",
    "filterPref": "begin",
    "locale": StoreManager.languageSort,
    "searchKey": key.isEmpty
        ? [
            "a",
            "b",
            "c",
            "d",
            "e",
            "f",
            "g",
            "h",
            "i",
            "j",
            "k",
            "l",
            "m",
            "n",
            "o",
            "p",
            "q",
            "r",
            "s",
            "t",
            "u",
            "v",
            "w",
            "x",
            "y",
            "z"
          ]
        : [key]
  };

  String url = artistsSearchUrl;

  Map<String, dynamic> map =
      await NetworkManager().post(url, jsonData: jsonData);
  return artistsModelFromJson(json.encode(map));

  await Future.delayed(Duration(seconds: 2));
  return artistsModelFromJson(_json);
}

String _json = """{
  "message": "Success",
  "respTime": "Response Time",
  "statusCode": "SC0000",
  "responseMap": {
    "artistList": [
      {
        "val": "katy perry",
        "count": 55
      },
      {
        "val": "katy perry and snoop dogg",
        "count": 2
      },
      {
        "val": "3oh3 and katy perry",
        "count": 1
      },
      {
        "val": "calvin harrispharrell williamskaty perrybig sean",
        "count": 1
      },
      {
        "val": "katy perry ft migos",
        "count": 1
      }
    ]
  }
}
""";
