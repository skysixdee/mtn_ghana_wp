// To parse this JSON data, do
//
//     final getRewardPointModel = getRewardPointModelFromJson(jsonString);

import 'dart:convert';

GetRewardPointModel getRewardPointModelFromJson(String str) =>
    GetRewardPointModel.fromJson(json.decode(str));

String getRewardPointModelToJson(GetRewardPointModel data) =>
    json.encode(data.toJson());

class GetRewardPointModel {
  int? respCode;
  String? message;
  int? rewardPoints;
  String? lastUpdated;

  GetRewardPointModel({
    this.respCode,
    this.message,
    this.rewardPoints,
    this.lastUpdated,
  });

  factory GetRewardPointModel.fromJson(Map<String, dynamic> json) =>
      GetRewardPointModel(
        respCode: json["respCode"],
        message: json["message"],
        rewardPoints: json["rewardPoints"],
        lastUpdated: json["lastUpdated"],
      );

  Map<String, dynamic> toJson() => {
        "respCode": respCode,
        "message": message,
        "rewardPoints": rewardPoints,
        "lastUpdated": lastUpdated,
      };
}
