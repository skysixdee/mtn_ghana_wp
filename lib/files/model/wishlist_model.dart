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
