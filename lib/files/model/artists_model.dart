// To parse this JSON data, do
//
//     final artistsModel = artistsModelFromJson(jsonString);

import 'dart:convert';

ArtistsModel artistsModelFromJson(String str) =>
    ArtistsModel.fromJson(json.decode(str));

String artistsModelToJson(ArtistsModel data) => json.encode(data.toJson());

class ArtistsModel {
  String? message;
  String? respTime;
  String? statusCode;
  ResponseMap? responseMap;

  ArtistsModel({
    this.message,
    this.respTime,
    this.statusCode,
    this.responseMap,
  });

  factory ArtistsModel.fromJson(Map<String, dynamic> json) => ArtistsModel(
        message: json["message"],
        respTime: json["respTime"],
        statusCode: json["statusCode"],
        responseMap: json["responseMap"] == null
            ? null
            : ResponseMap.fromJson(json["responseMap"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "respTime": respTime,
        "statusCode": statusCode,
        "responseMap": responseMap?.toJson(),
      };
}

class ResponseMap {
  List<ArtistList>? artistList;
  int? resultCount;
  ResponseMap({
    this.artistList,
    this.resultCount,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        artistList: json["artistList"] == null
            ? []
            : List<ArtistList>.from(
                json["artistList"]!.map((x) => ArtistList.fromJson(x))),
        resultCount: json['resultCount'],
      );

  Map<String, dynamic> toJson() => {
        "artistList": artistList == null
            ? []
            : List<dynamic>.from(artistList!.map((x) => x.toJson())),
      };
}

class ArtistList {
  String? val;
  int? count;

  ArtistList({
    this.val,
    this.count,
  });

  factory ArtistList.fromJson(Map<String, dynamic> json) => ArtistList(
        val: json["val"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "val": val,
        "count": count,
      };
}
