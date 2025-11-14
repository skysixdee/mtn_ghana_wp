// To parse this JSON data, do
//
//     final searchResultModel = searchResultModelFromJson(jsonString);
// To parse this JSON data, do
//
//     final searchResultModel = searchResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/tune_info.dart';

SearchResultModel searchResultModelFromJson(String str) =>
    SearchResultModel.fromJson(json.decode(str));

String searchResultModelToJson(SearchResultModel data) =>
    json.encode(data.toJson());

class SearchResultModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  SearchResultModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      SearchResultModel(
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
  List<ArtistDetailList>? artistDetailList;
  int? resultCount;
  ResponseMap({
    this.toneList,
    this.resultCount,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        toneList: json["toneList"] == null
            ? []
            : List<TuneInfo>.from(
                json["toneList"]!.map((x) => TuneInfo.fromJson(x))),
        resultCount: json["resultCount"],
      );

  Map<String, dynamic> toJson() => {
        "toneList": toneList == null
            ? []
            : List<dynamic>.from(toneList!.map((x) => x.toJson())),
      };
}

class ArtistDetailList {
  String? matchedParam;
  String? count;

  ArtistDetailList({
    this.matchedParam,
    this.count,
  });

  factory ArtistDetailList.fromJson(Map<String, dynamic> json) =>
      ArtistDetailList(
        matchedParam: json["matchedParam"],
        count: json["count"] ?? json['resultCount'],
      );

  Map<String, dynamic> toJson() => {
        "matchedParam": matchedParam,
        "count": count,
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
import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/tune_info.dart';

SearchResultModel searchResultModelFromJson(String str) =>
    SearchResultModel.fromJson(json.decode(str));

String searchResultModelToJson(SearchResultModel data) =>
    json.encode(data.toJson());

class SearchResultModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  SearchResultModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      SearchResultModel(
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
  CountList? countList;
  List<TuneInfo>? toneList;
  int? songTotalCount;
  int? toneTotalCount;
  List<TuneInfo>? songList;
  int? albumTotalCount;

  ResponseMap({
    this.countList,
    this.toneList,
    this.songTotalCount,
    this.toneTotalCount,
    this.songList,
    this.albumTotalCount,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        countList: json["countList"] == null
            ? null
            : CountList.fromJson(json["countList"]),
        toneList: json["toneList"] == null
            ? []
            : List<TuneInfo>.from(
                json["toneList"]!.map((x) => TuneInfo.fromJson(x))),
        songTotalCount: json["songTotalCount"],
        toneTotalCount: json["toneTotalCount"],
        songList: json["songList"] == null
            ? []
            : List<TuneInfo>.from(
                json["songList"]!.map((x) => TuneInfo.fromJson(x))),
        albumTotalCount: json["albumTotalCount"],
      );

  Map<String, dynamic> toJson() => {
        "countList": countList?.toJson(),
        "toneList": toneList == null
            ? []
            : List<dynamic>.from(toneList!.map((x) => x.toJson())),
        "songTotalCount": songTotalCount,
        "toneTotalCount": toneTotalCount,
        "songList": songList == null
            ? []
            : List<dynamic>.from(songList!.map((x) => x.toJson())),
        "albumTotalCount": albumTotalCount,
      };
}

class CountList {
  List<ArtistDetailList>? artistDetailList;

  CountList({
    this.artistDetailList,
  });

  factory CountList.fromJson(Map<String, dynamic> json) => CountList(
        artistDetailList: json["artistDetailList"] == null
            ? []
            : List<ArtistDetailList>.from(json["artistDetailList"]!
                .map((x) => ArtistDetailList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "artistDetailList": artistDetailList == null
            ? []
            : List<dynamic>.from(artistDetailList!.map((x) => x.toJson())),
      };
}

class ArtistDetailList {
  String? matchedParam;
  String? count;

  ArtistDetailList({
    this.matchedParam,
    this.count,
  });

  factory ArtistDetailList.fromJson(Map<String, dynamic> json) =>
      ArtistDetailList(
        matchedParam: json["matchedParam"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "matchedParam": matchedParam,
        "count": count,
      };
}
*/
