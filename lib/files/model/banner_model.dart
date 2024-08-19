// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';

BannerModel bannerModelFromJson(String str) =>
    BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  BannerModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        responseMap: json["responseMap"] == null
            ? null
            : ResponseMap.fromJson(json["responseMap"]),
        message: json["message"],
        respTime: json["respTime"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "responseMap": responseMap?.toJson(),
        "message": message,
        "respTime": respTime,
        "statusCode": statusCode,
      };
}

class ResponseMap {
  List<Banner>? banners;

  ResponseMap({
    this.banners,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        banners: json["banners"] == null
            ? []
            : List<Banner>.from(
                json["banners"]!.map((x) => Banner.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "banners": banners == null
            ? []
            : List<dynamic>.from(banners!.map((x) => x.toJson())),
      };
}

class Banner {
  String? language;
  String? bannerPath;
  String? type;
  String? searchKey;
  String? bannerOrder;

  Banner({
    this.language,
    this.bannerPath,
    this.type,
    this.searchKey,
    this.bannerOrder,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        language: json["language"],
        bannerPath: json["bannerPath"],
        type: json["type"],
        searchKey: json["searchKey"],
        bannerOrder: json["bannerOrder"],
      );

  Map<String, dynamic> toJson() => {
        "language": language,
        "bannerPath": bannerPath,
        "type": type,
        "searchKey": searchKey,
        "bannerOrder": bannerOrder,
      };
}
