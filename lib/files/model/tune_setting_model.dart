// To parse this JSON data, do
//
//     final myTuneShuffleModel = myTuneShuffleModelFromJson(jsonString);

import 'dart:convert';

TuneSettingModel myTuneShuffleModelFromJson(String str) =>
    TuneSettingModel.fromJson(json.decode(str));

String myTuneShuffleModelToJson(TuneSettingModel data) =>
    json.encode(data.toJson());

class TuneSettingModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  TuneSettingModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory TuneSettingModel.fromJson(Map<String, dynamic> json) =>
      TuneSettingModel(
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
  ResponseMap();

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap();

  Map<String, dynamic> toJson() => {};
}
