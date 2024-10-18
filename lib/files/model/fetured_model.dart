// To parse this JSON data, do
//
//     final feturedModel = feturedModelFromJson(jsonString);

import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/tune_info.dart';

FeturedModel feturedModelFromJson(String str) =>
    FeturedModel.fromJson(json.decode(str));

String feturedModelToJson(FeturedModel data) => json.encode(data.toJson());

class FeturedModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  FeturedModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory FeturedModel.fromJson(Map<String, dynamic> json) => FeturedModel(
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
  String? responseDescription;
  List<TuneInfo>? recommendationSongsList;

  ResponseMap({
    this.responseDescription,
    this.recommendationSongsList,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        responseDescription: json["responseDescription"],
        recommendationSongsList: json["recommendationSongsList"] == null
            ? []
            : List<TuneInfo>.from(json["recommendationSongsList"]!
                .map((x) => TuneInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "responseDescription": responseDescription,
        "recommendationSongsList": recommendationSongsList == null
            ? []
            : List<dynamic>.from(
                recommendationSongsList!.map((x) => x.toJson())),
      };
}
