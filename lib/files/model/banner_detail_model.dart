// // To parse this JSON data, do
// //
// //     final bannerDetailModel = bannerDetailModelFromJson(jsonString);

// import 'dart:convert';

// import 'package:mtn_ghana_wp/files/model/tune_info.dart';

// BannerDetailModel bannerDetailModelFromJson(String str) =>
//     BannerDetailModel.fromJson(json.decode(str));

// String bannerDetailModelToJson(BannerDetailModel data) =>
//     json.encode(data.toJson());

// class BannerDetailModel {
//   ResponseMap? responseMap;
//   String? message;
//   String? respTime;
//   String? statusCode;

//   BannerDetailModel({
//     this.responseMap,
//     this.message,
//     this.respTime,
//     this.statusCode,
//   });

//   factory BannerDetailModel.fromJson(Map<String, dynamic> json) =>
//       BannerDetailModel(
//         responseMap: json["responseMap"] == null
//             ? null
//             : ResponseMap.fromJson(json["responseMap"]),
//         message: json["message"],
//         respTime: json["respTime"],
//         statusCode: json["statusCode"],
//       );

//   Map<String, dynamic> toJson() => {
//         "responseMap": responseMap?.toJson(),
//         "message": message,
//         "respTime": respTime,
//         "statusCode": statusCode,
//       };
// }

// class ResponseMap {
//   List<TuneInfo>? searchList;

//   ResponseMap({
//     this.searchList,
//   });

//   factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
//         searchList: json["searchList"] == null
//             ? []
//             : List<TuneInfo>.from(
//                 json["searchList"]!.map((x) => TuneInfo.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "searchList": searchList == null
//             ? []
//             : List<dynamic>.from(searchList!.map((x) => x.toJson())),
//       };
// }

// To parse this JSON data, do
//
//     final bannerDetailModel = bannerDetailModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final bannerDetailModel = bannerDetailModelFromJson(jsonString);
// To parse this JSON data, do
//
//     final bannerDetailModel = bannerDetailModelFromJson(jsonString);

import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/tune_info.dart';

BannerDetailModel bannerDetailModelFromJson(String str) =>
    BannerDetailModel.fromJson(json.decode(str));

String bannerDetailModelToJson(BannerDetailModel data) =>
    json.encode(data.toJson());

class BannerDetailModel {
  String? respCode;
  String? message;
  ResponseMap? responseMap;

  BannerDetailModel({
    this.respCode,
    this.message,
    this.responseMap,
  });

  factory BannerDetailModel.fromJson(Map<String, dynamic> json) =>
      BannerDetailModel(
        respCode: json["respCode"],
        message: json["message"],
        responseMap: json["responseMap"] == null
            ? null
            : ResponseMap.fromJson(json["responseMap"]),
      );

  Map<String, dynamic> toJson() => {
        "respCode": respCode,
        "message": message,
        "responseMap": responseMap?.toJson(),
      };
}

class ResponseMap {
  List<TuneInfo>? bannerDetails;

  ResponseMap({
    this.bannerDetails,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        bannerDetails: json["bannerDetails"] == null
            ? []
            : List<TuneInfo>.from(
                json["bannerDetails"]!.map((x) => TuneInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bannerDetails": bannerDetails == null
            ? []
            : List<dynamic>.from(bannerDetails!.map((x) => x.toJson())),
      };
}
/*
class BannerDetail {
    String? location;
    String? previewImage;
    String? toneId;
    String? contentName;
    String? artistName;
    String? albumName;

    BannerDetail({
        this.location,
        this.previewImage,
        this.toneId,
        this.contentName,
        this.artistName,
        this.albumName,
    });

    factory BannerDetail.fromJson(Map<String, dynamic> json) => BannerDetail(
        location: json["location"],
        previewImage: json["previewImage"],
        toneId: json["toneId"],
        contentName: json["contentName"],
        artistName: json["artistName"],
        albumName: json["albumName"],
    );

    Map<String, dynamic> toJson() => {
        "location": location,
        "previewImage": previewImage,
        "toneId": toneId,
        "contentName": contentName,
        "artistName": artistName,
        "albumName": albumName,
    };
}

*/
/*
import 'dart:convert';

import 'package:qatar_ooredoo_wp/files/model/tune_info.dart';

BannerDetailModel bannerDetailModelFromJson(String str) =>
    BannerDetailModel.fromJson(json.decode(str));

String bannerDetailModelToJson(BannerDetailModel data) =>
    json.encode(data.toJson());

class BannerDetailModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  BannerDetailModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory BannerDetailModel.fromJson(Map<String, dynamic> json) =>
      BannerDetailModel(
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
  List<TuneInfo>? searchList;

  ResponseMap({
    this.searchList,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        searchList: json["searchList"] == null
            ? []
            : List<TuneInfo>.from(
                json["searchList"]!.map((x) => TuneInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "searchList": searchList == null
            ? []
            : List<dynamic>.from(searchList!.map((x) => x.toJson())),
      };
}
*/
