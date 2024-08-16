// To parse this JSON data, do
//
//     final genericModel = genericModelFromJson(jsonString);

import 'dart:convert';

GenericModel genericModelFromJson(String str) =>
    GenericModel.fromJson(json.decode(str));

String genericModelToJson(GenericModel data) => json.encode(data.toJson());

class GenericModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  GenericModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory GenericModel.fromJson(Map<String, dynamic> json) => GenericModel(
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
