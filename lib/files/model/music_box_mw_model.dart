

import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/tune_info.dart';







 

MusicBoxMwModel musicBoxModelMwFromJson(String str) =>
    MusicBoxMwModel.fromJson(json.decode(str));

String musicBoxModelMwToJson(MusicBoxMwModel data) =>
    json.encode(data.toJson());

class MusicBoxMwModel {
  int? respCode;
  String? message;
  ResponseMap? responseMap;

  MusicBoxMwModel({
    this.respCode,
    this.message,
    this.responseMap,
  });

  factory MusicBoxMwModel.fromJson(Map<String, dynamic> json) => MusicBoxMwModel(
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
  List<TuneInfo>? musicBoxSearchList;

  ResponseMap({
    this.musicBoxSearchList,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        musicBoxSearchList: json["musicBoxSearchList"] == null
            ? []
            : List<TuneInfo>.from(json["musicBoxSearchList"]
                .map((x) => TuneInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "musicBoxSearchList": musicBoxSearchList == null
            ? []
            : List<dynamic>.from(musicBoxSearchList!.map((x) => x.toJson())),
      };
}
