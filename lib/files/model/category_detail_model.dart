// To parse this JSON data, do
//
//     final categoryDetailModel = categoryDetailModelFromJson(jsonString);

import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/tune_info.dart';

CategoryDetailModel categoryDetailModelFromJson(String str) =>
    CategoryDetailModel.fromJson(json.decode(str));

String categoryDetailModelToJson(CategoryDetailModel data) =>
    json.encode(data.toJson());

class CategoryDetailModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  CategoryDetailModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory CategoryDetailModel.fromJson(Map<String, dynamic> json) =>
      CategoryDetailModel(
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
  List<TuneInfo>? toneList;

  ResponseMap({
    this.toneList,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        toneList: json["toneList"] == null
            ? []
            : List<TuneInfo>.from(
                json["toneList"]!.map((x) => TuneInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "toneList": toneList == null
            ? []
            : List<dynamic>.from(toneList!.map((x) => x.toJson())),
      };
}
/*
class ToneList {
  String? toneId;
  String? toneName;
  String? artistName;
  String? albumName;
  int? price;
  int? categoryId;
  String? expiryDate;
  String? toneIdStreamingUrl;
  String? toneIdpreviewImageUrl;

  ToneList({
    this.toneId,
    this.toneName,
    this.artistName,
    this.albumName,
    this.price,
    this.categoryId,
    this.expiryDate,
    this.toneIdStreamingUrl,
    this.toneIdpreviewImageUrl,
  });

  factory ToneList.fromJson(Map<String, dynamic> json) => ToneList(
        toneId: json["toneId"],
        toneName: json["toneName"],
        artistName: json["artistName"],
        albumName: json["albumName"],
        price: json["price"],
        categoryId: json["categoryId"],
        expiryDate: json["expiryDate"],
        toneIdStreamingUrl: json["toneIdStreamingUrl"],
        toneIdpreviewImageUrl: json["toneIdpreviewImageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "toneId": toneId,
        "toneName": toneName,
        "artistName": artistName,
        "albumName": albumName,
        "price": price,
        "categoryId": categoryId,
        "expiryDate": expiryDate,
        "toneIdStreamingUrl": toneIdStreamingUrl,
        "toneIdpreviewImageUrl": toneIdpreviewImageUrl,
      };
}
*/
/*
CategoryDetailModel categoryDetailModelFromJson(String str) =>
    CategoryDetailModel.fromJson(json.decode(str));

String categoryDetailModelToJson(CategoryDetailModel data) =>
    json.encode(data.toJson());

class CategoryDetailModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  CategoryDetailModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory CategoryDetailModel.fromJson(Map<String, dynamic> json) =>
      CategoryDetailModel(
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
  int? totalCount;

  ResponseMap({
    this.searchList,
    this.totalCount,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        searchList: json["searchList"] == null
            ? []
            : List<TuneInfo>.from(
                json["searchList"]!.map((x) => TuneInfo.fromJson(x))),
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "searchList": searchList == null
            ? []
            : List<dynamic>.from(searchList!.map((x) => x.toJson())),
        "totalCount": totalCount,
      };
}
*/
