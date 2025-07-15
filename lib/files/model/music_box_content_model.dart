// To parse this JSON data, do
//
//     final musicBoxContentModel = musicBoxContentModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final musicBoxContentModel = musicBoxContentModelFromJson(jsonString);

import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/tune_info.dart';
// To parse this JSON data, do
//
//     final musicBoxContentModel = musicBoxContentModelFromJson(jsonString);

import 'dart:convert';

MusicBoxContentModel musicBoxContentModelFromJson(String str) =>
    MusicBoxContentModel.fromJson(json.decode(str));

String musicBoxContentModelToJson(MusicBoxContentModel data) =>
    json.encode(data.toJson());

class MusicBoxContentModel {
  int? respCode;
  String? message;
  String? respTime;
  ResponseMap? responseMap;

  MusicBoxContentModel({
    this.respCode,
    this.message,
    this.respTime,
    this.responseMap,
  });

  factory MusicBoxContentModel.fromJson(Map<String, dynamic> json) =>
      MusicBoxContentModel(
        respCode: json["respCode"],
        message: json["message"],
        respTime: json["respTime"],
        responseMap: json["responseMap"] == null
            ? null
            : ResponseMap.fromJson(json["responseMap"]),
      );

  Map<String, dynamic> toJson() => {
        "respCode": respCode,
        "message": message,
        "respTime": respTime,
        "responseMap": responseMap?.toJson(),
      };
}

class ResponseMap {
  List<TuneInfo>? tonelist;

  ResponseMap({
    this.tonelist,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        tonelist: json["toneList"] == null
            ? []
            : List<TuneInfo>.from(
                json["toneList"]!.map((x) => TuneInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "toneList": tonelist == null
            ? []
            : List<dynamic>.from(tonelist!.map((x) => x.toJson())),
      };
}
/*
class Tonelist {
    String? toneId;
    String? toneName;
    String? artistName;
    String? albumName;
    int? categoryId;
    String? toneIdStreamingUrl;
    String? toneIdpreviewImageUrl;

    Tonelist({
        this.toneId,
        this.toneName,
        this.artistName,
        this.albumName,
        this.categoryId,
        this.toneIdStreamingUrl,
        this.toneIdpreviewImageUrl,
    });

    factory Tonelist.fromJson(Map<String, dynamic> json) => Tonelist(
        toneId: json["toneId"],
        toneName: json["toneName"],
        artistName: json["artistName"],
        albumName: json["albumName"],
        categoryId: json["categoryId"],
        toneIdStreamingUrl: json["toneIdStreamingUrl"],
        toneIdpreviewImageUrl: json["toneIdpreviewImageUrl"],
    );

    Map<String, dynamic> toJson() => {
        "toneId": toneId,
        "toneName": toneName,
        "artistName": artistName,
        "albumName": albumName,
        "categoryId": categoryId,
        "toneIdStreamingUrl": toneIdStreamingUrl,
        "toneIdpreviewImageUrl": toneIdpreviewImageUrl,
    };
}
*/
/*
MusicBoxContentModel musicBoxContentModelFromJson(String str) => MusicBoxContentModel.fromJson(json.decode(str));

String musicBoxContentModelToJson(MusicBoxContentModel data) => json.encode(data.toJson());

class MusicBoxContentModel {
    int? respCode;
    String? message;
    String? respTime;
    List<TuneInfo>? tonelist;

    MusicBoxContentModel({
        this.respCode,
        this.message,
        this.respTime,
        this.tonelist,
    });

    factory MusicBoxContentModel.fromJson(Map<String, dynamic> json) => MusicBoxContentModel(
        respCode: json["respCode"],
        message: json["message"],
        respTime: json["respTime"],
        tonelist: json["tonelist"] == null ? [] : List<TuneInfo>.from(json["tonelist"]!.map((x) => TuneInfo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "respCode": respCode,
        "message": message,
        "respTime": respTime,
        "tonelist": tonelist == null ? [] : List<dynamic>.from(tonelist!.map((x) => x.toJson())),
    };
}
*/

/*class Tonelist {
    String? toneId;
    String? toneName;
    String? artistName;
    String? albumName;
    int? categoryId;
    String? toneIdStreamingUrl;
    String? toneIdpreviewImageUrl;

    Tonelist({
        this.toneId,
        this.toneName,
        this.artistName,
        this.albumName,
        this.categoryId,
        this.toneIdStreamingUrl,
        this.toneIdpreviewImageUrl,
    });

    factory Tonelist.fromJson(Map<String, dynamic> json) => Tonelist(
        toneId: json["toneId"],
        toneName: json["toneName"],
        artistName: json["artistName"],
        albumName: json["albumName"],
        categoryId: json["categoryId"],
        toneIdStreamingUrl: json["toneIdStreamingUrl"],
        toneIdpreviewImageUrl: json["toneIdpreviewImageUrl"],
    );

    Map<String, dynamic> toJson() => {
        "toneId": toneId,
        "toneName": toneName,
        "artistName": artistName,
        "albumName": albumName,
        "categoryId": categoryId,
        "toneIdStreamingUrl": toneIdStreamingUrl,
        "toneIdpreviewImageUrl": toneIdpreviewImageUrl,
    };
}*/

/*import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/tune_info.dart';

MusicBoxContentModel musicBoxContentModelFromJson(String str) =>
    MusicBoxContentModel.fromJson(json.decode(str));

String musicBoxContentModelToJson(MusicBoxContentModel data) =>
    json.encode(data.toJson());

class MusicBoxContentModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  MusicBoxContentModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory MusicBoxContentModel.fromJson(Map<String, dynamic> json) =>
      MusicBoxContentModel(
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
} */
