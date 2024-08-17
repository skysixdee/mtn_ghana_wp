// To parse this JSON data, do
//
//     final musicBoxModel = musicBoxModelFromJson(jsonString);

import 'dart:convert';

import 'package:etisalat/files/model/tune_info.dart';

MusicBoxModel musicBoxModelFromJson(String str) =>
    MusicBoxModel.fromJson(json.decode(str));

String musicBoxModelToJson(MusicBoxModel data) => json.encode(data.toJson());

class MusicBoxModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  MusicBoxModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory MusicBoxModel.fromJson(Map<String, dynamic> json) => MusicBoxModel(
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
  List<TuneInfo>? musicBoxSearchList;

  ResponseMap({
    this.musicBoxSearchList,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        musicBoxSearchList: json["musicBoxSearchList"] == null
            ? []
            : List<TuneInfo>.from(
                json["musicBoxSearchList"]!.map((x) => TuneInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "musicBoxSearchList": musicBoxSearchList == null
            ? []
            : List<dynamic>.from(musicBoxSearchList!.map((x) => x.toJson())),
      };
}
