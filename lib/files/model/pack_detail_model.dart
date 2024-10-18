// To parse this JSON data, do
//
//     final packDetailModel = packDetailModelFromJson(jsonString);

import 'dart:convert';

PackDetailModel packDetailModelFromJson(String str) =>
    PackDetailModel.fromJson(json.decode(str));

String packDetailModelToJson(PackDetailModel data) =>
    json.encode(data.toJson());

class PackDetailModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  PackDetailModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory PackDetailModel.fromJson(Map<String, dynamic> json) =>
      PackDetailModel(
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
  PackStatusDetails? packStatusDetails;

  ResponseMap({
    this.packStatusDetails,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        packStatusDetails: json["packStatusDetails"] == null
            ? null
            : PackStatusDetails.fromJson(json["packStatusDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "packStatusDetails": packStatusDetails?.toJson(),
      };
}

class PackStatusDetails {
  String? languageId;
  String? packName;

  PackStatusDetails({
    this.languageId,
    this.packName,
  });

  factory PackStatusDetails.fromJson(Map<String, dynamic> json) =>
      PackStatusDetails(
        languageId: json["languageId"],
        packName: json["packName"],
      );

  Map<String, dynamic> toJson() => {
        "languageId": languageId,
        "packName": packName,
      };
}
