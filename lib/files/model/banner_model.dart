// // To parse this JSON data, do
// //
// //     final bannerModel = bannerModelFromJson(jsonString);

// import 'dart:convert';

// BannerModel bannerModelFromJson(String str) =>
//     BannerModel.fromJson(json.decode(str));

// String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

// class BannerModel {
//   ResponseMap? responseMap;
//   String? message;
//   String? respTime;
//   String? statusCode;

//   BannerModel({
//     this.responseMap,
//     this.message,
//     this.respTime,
//     this.statusCode,
//   });

//   factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
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
//   List<Banner>? banners;

//   ResponseMap({
//     this.banners,
//   });

//   factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
//         banners: json["banners"] == null
//             ? []
//             : List<Banner>.from(
//                 json["banners"]!.map((x) => Banner.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "banners": banners == null
//             ? []
//             : List<dynamic>.from(banners!.map((x) => x.toJson())),
//       };
// }

// class Banner {
//   String? language;
//   String? bannerPath;
//   String? type;
//   String? searchKey;
//   String? bannerOrder;

//   Banner({
//     this.language,
//     this.bannerPath,
//     this.type,
//     this.searchKey,
//     this.bannerOrder,
//   });

//   factory Banner.fromJson(Map<String, dynamic> json) => Banner(
//         language: json["language"],
//         bannerPath: json["bannerPath"],
//         type: json["type"],
//         searchKey: json["searchKey"],
//         bannerOrder: json["bannerOrder"],
//       );

//   Map<String, dynamic> toJson() => {
//         "language": language,
//         "bannerPath": bannerPath,
//         "type": type,
//         "searchKey": searchKey,
//         "bannerOrder": bannerOrder,
//       };
// }






// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final homeBannerModel = homeBannerModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final homeBannerModel = homeBannerModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final homeBannerModel = homeBannerModelFromJson(jsonString);

import 'dart:convert';

BannerModel homeBannerModelFromJson(String str) =>
    BannerModel.fromJson(json.decode(str));

String homeBannerModelToJson(BannerModel data) =>
    json.encode(data.toJson());

class BannerModel {
  String? respCode;
  String? message;
  ResponseMap? responseMap;

  BannerModel({
    this.respCode,
    this.message,
    this.responseMap,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      BannerModel(
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
  List<BannerList>? bannerList;

  ResponseMap({
    this.bannerList,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        bannerList: json["bannerList"] == null
            ? []
            : List<BannerList>.from(
                json["bannerList"]!.map((x) => BannerList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bannerList": bannerList == null
            ? []
            : List<dynamic>.from(bannerList!.map((x) => x.toJson())),
      };
}

class BannerList {
  String? language;
  String? bannerId;
  String? bannerPath;
  String? type;
  String? searchKey;
  String? bannerOrder;

  BannerList({
    this.language,
    this.bannerId,
    this.bannerPath,
    this.type,
    this.searchKey,
    this.bannerOrder,
  });

  factory BannerList.fromJson(Map<String, dynamic> json) => BannerList(
        language: json["language"],
        bannerId: json["bannerId"],
        bannerPath: json["bannerPath"],
        type: json["type"],
        searchKey: json["searchKey"],
        bannerOrder: json["bannerOrder"],
      );

  Map<String, dynamic> toJson() => {
        "language": language,
        "bannerId": bannerId,
        "bannerPath": bannerPath,
        "type": type,
        "searchKey": searchKey,
        "bannerOrder": bannerOrder,
      };
}



