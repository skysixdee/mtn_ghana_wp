// To parse this JSON data, do
//
//     final regenerateModel = regenerateModelFromJson(jsonString);

import 'dart:convert';

RegenerateModel regenerateModelFromJson(String str) =>
    RegenerateModel.fromJson(json.decode(str));

String regenerateModelToJson(RegenerateModel data) =>
    json.encode(data.toJson());

class RegenerateModel {
  ResponseMap? responseMap;
  String? respTime;
  String? statusCode;

  RegenerateModel({
    this.responseMap,
    this.respTime,
    this.statusCode,
  });

  factory RegenerateModel.fromJson(Map<String, dynamic> json) =>
      RegenerateModel(
        responseMap: json["responseMap"] == null
            ? null
            : ResponseMap.fromJson(json["responseMap"]),
        respTime: json["respTime"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "responseMap": responseMap?.toJson(),
        "respTime": respTime,
        "statusCode": statusCode,
      };
}

class ResponseMap {
  int? expiry;
  String? accessToken;
  String? refreshToken;

  ResponseMap({
    this.expiry,
    this.accessToken,
    this.refreshToken,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        expiry: json["expiry"],
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "expiry": expiry,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };
}
