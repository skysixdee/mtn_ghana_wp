// To parse this JSON data, do
//
//     final securityTokenModel = securityTokenModelFromJson(jsonString);

import 'dart:convert';

SecurityTokenModel securityTokenModelFromJson(String str) =>
    SecurityTokenModel.fromJson(json.decode(str));

String securityTokenModelToJson(SecurityTokenModel data) =>
    json.encode(data.toJson());

class SecurityTokenModel {
  ResponseMap? responseMap;
  String? respTime;
  String? statusCode;

  SecurityTokenModel({
    this.responseMap,
    this.respTime,
    this.statusCode,
  });

  factory SecurityTokenModel.fromJson(Map<String, dynamic> json) =>
      SecurityTokenModel(
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
  String? securityCounter;

  ResponseMap({
    this.securityCounter,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        securityCounter: json["securityCounter"],
      );

  Map<String, dynamic> toJson() => {
        "securityCounter": securityCounter,
      };
}
