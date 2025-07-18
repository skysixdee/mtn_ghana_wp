// To parse this JSON data, do
//
//     final wishlistModel = wishlistModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final wishlistModel = wishlistModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final wishlistModel = wishlistModelFromJson(jsonString);

import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/tune_info.dart';

WishlistModel wishlistModelFromJson(String str) =>
    WishlistModel.fromJson(json.decode(str));

String wishlistModelToJson(WishlistModel data) => json.encode(data.toJson());

class WishlistModel {
  int? respCode;
  String? message;
  List<TuneInfo>? wishlist;

  WishlistModel({
    this.respCode,
    this.message,
    this.wishlist,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
        respCode: json["respCode"],
        message: json["message"],
        wishlist: json["wishlist"] == null
            ? []
            : List<TuneInfo>.from(
                json["wishlist"]!.map((x) => TuneInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "respCode": respCode,
        "message": message,
        "wishlist": wishlist == null
            ? []
            : List<dynamic>.from(wishlist!.map((x) => x.toJson())),
      };
}
/*
class Wishlist {
    int? contentId;
    String? contentPath;
    String? previewImage;
    String? contentNameL1;
    String? albumL1;
    String? artistL1;
    String? contentNameL2;
    String? albumL2;
    String? artistL2;
    String? price;
    String? languageCode;
    int? type;

    Wishlist({
        this.contentId,
        this.contentPath,
        this.previewImage,
        this.contentNameL1,
        this.albumL1,
        this.artistL1,
        this.contentNameL2,
        this.albumL2,
        this.artistL2,
        this.price,
        this.languageCode,
        this.type,
    });

    factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
        contentId: json["contentId"],
        contentPath: json["contentPath"],
        previewImage: json["previewImage"],
        contentNameL1: json["contentName_L1"],
        albumL1: json["album_L1"],
        artistL1: json["artist_L1"],
        contentNameL2: json["contentName_L2"],
        albumL2: json["album_L2"],
        artistL2: json["artist_L2"],
        price: json["price"],
        languageCode: json["languageCode"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "contentId": contentId,
        "contentPath": contentPath,
        "previewImage": previewImage,
        "contentName_L1": contentNameL1,
        "album_L1": albumL1,
        "artist_L1": artistL1,
        "contentName_L2": contentNameL2,
        "album_L2": albumL2,
        "artist_L2": artistL2,
        "price": price,
        "languageCode": languageCode,
        "type": type,
    };
}
*/
/*
import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/tune_info.dart';

WishlistModel wishlistModelFromJson(String str) =>
    WishlistModel.fromJson(json.decode(str));

String wishlistModelToJson(WishlistModel data) => json.encode(data.toJson());

class WishlistModel {
  int? respCode;
  String? message;
  List<TuneInfo>? history;

  WishlistModel({
    this.respCode,
    this.message,
    this.history,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
        respCode: json["respCode"],
        message: json["message"],
        history: json["wishlist"] == null
            ? []
            : List<TuneInfo>.from(
                json["wishlist"]!.map((x) => TuneInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "respCode": respCode,
        "message": message,
        "wishlist": history == null
            ? []
            : List<dynamic>.from(history!.map((x) => x.toJson())),
      };
}
*/
/*
class History {
    int? contentId;
    String? contentPath;
    String? previewImage;
    String? contentNameL1;
    String? albumL1;
    String? artistL1;
    String? contentNameL2;
    String? albumL2;
    String? artistL2;
    String? price;
    String? languageCode;
    int? type;

    History({
        this.contentId,
        this.contentPath,
        this.previewImage,
        this.contentNameL1,
        this.albumL1,
        this.artistL1,
        this.contentNameL2,
        this.albumL2,
        this.artistL2,
        this.price,
        this.languageCode,
        this.type,
    });

    factory History.fromJson(Map<String, dynamic> json) => History(
        contentId: json["contentId"],
        contentPath: json["contentPath"],
        previewImage: json["previewImage"],
        contentNameL1: json["contentName_L1"],
        albumL1: json["album_L1"],
        artistL1: json["artist_L1"],
        contentNameL2: json["contentName_L2"],
        albumL2: json["album_L2"],
        artistL2: json["artist_L2"],
        price: json["price"],
        languageCode: json["languageCode"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "contentId": contentId,
        "contentPath": contentPath,
        "previewImage": previewImage,
        "contentName_L1": contentNameL1,
        "album_L1": albumL1,
        "artist_L1": artistL1,
        "contentName_L2": contentNameL2,
        "album_L2": albumL2,
        "artist_L2": artistL2,
        "price": price,
        "languageCode": languageCode,
        "type": type,
    };
}
*/
/*

import 'dart:convert';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';


WishlistModel wishlistModelFromJson(String str) =>
    WishlistModel.fromJson(json.decode(str));

String wishlistModelToJson(WishlistModel data) => json.encode(data.toJson());

class WishlistModel {
  int? respCode;
  String? message;
  List<TuneInfo>? wishlist;

  WishlistModel({
    this.respCode,
    this.message,
    this.wishlist,
  });

  // factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
  //       respCode: json["respCode"],
  //       message: json["message"],
  //       wishlist: json["wishlist"] == null
  //           ? []
  //           : List<TuneInfo>.from(
  //               json["wishlist"]!.map((x) => TuneInfo.fromJson(x))),
  //     );

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
  respCode: json["respCode"],
  message: json["message"],
  wishlist: json["wishlist"] == null
      ? []
      : List<TuneInfo>.from(
          json["wishlist"]!.map((x) {
            try {
              // Clean up the raw map before passing to TuneInfo
              Map<String, dynamic> fixedMap = Map<String, dynamic>.from(x);

              // Ensure all expected String fields are converted safely
              fixedMap['price'] = x['price']?.toString();
              fixedMap['contentId'] = x['contentId']?.toString();
              fixedMap['albumName'] = x['album_L1'];
              fixedMap['artistName'] = x['artist_L1'];
              fixedMap['toneName'] = x['contentName_L1'];
              fixedMap['previewImageUrl'] = x['previewImage'];
              fixedMap['toneIdStreamingUrl'] = x['contentPath'];
              fixedMap['toneIdpreviewImageUrl'] = x['previewImage'];

              return TuneInfo.fromJson(fixedMap);
            } catch (e) {
              print("Error parsing TuneInfo: $e");
              return TuneInfo(); // return empty object on failure
            }
          }),
        ),
);


  Map<String, dynamic> toJson() => {
        "respCode": respCode,
        "message": message,
        "wishlist": wishlist == null
            ? []
            : List<dynamic>.from(wishlist!.map((x) => x.toJson())),
      };
}













// import 'dart:convert';

// import 'package:mtn_ghana_wp/files/model/tune_info.dart';

// WishlistModel wishlistModelFromJson(String str) =>
//     WishlistModel.fromJson(json.decode(str));

// String wishlistModelToJson(WishlistModel data) => json.encode(data.toJson());

// class WishlistModel {
//   ResponseMap? responseMap;
//   String? message;
//   String? respTime;
//   String? statusCode;

//   WishlistModel({
//     this.responseMap,
//     this.message,
//     this.respTime,
//     this.statusCode,
//   });

//   factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
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
//   String? descriptiion;
//   List<TuneInfo>? toneDetailsList;

//   ResponseMap({
//     this.descriptiion,
//     this.toneDetailsList,
//   });

//   factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
//         descriptiion: json["descriptiion"],
//         toneDetailsList: json["toneDetailsList"] == null
//             ? []
//             : List<TuneInfo>.from(
//                 json["toneDetailsList"]!.map((x) => TuneInfo.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "descriptiion": descriptiion,
//         "toneDetailsList": toneDetailsList == null
//             ? []
//             : List<dynamic>.from(toneDetailsList!.map((x) => x.toJson())),
//       };
// }
*/
