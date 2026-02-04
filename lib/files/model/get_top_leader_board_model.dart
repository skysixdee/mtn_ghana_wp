// To parse this JSON data, do
//
//     final getLeaderBoardModel = getLeaderBoardModelFromJson(jsonString);

import 'dart:convert';

GetLeaderBoardModel getLeaderBoardModelFromJson(String str) =>
    GetLeaderBoardModel.fromJson(json.decode(str));

String getLeaderBoardModelToJson(GetLeaderBoardModel data) =>
    json.encode(data.toJson());

class GetLeaderBoardModel {
  int? respCode;
  String? message;
  List<PointsList>? pointsList;

  GetLeaderBoardModel({
    this.respCode,
    this.message,
    this.pointsList,
  });

  factory GetLeaderBoardModel.fromJson(Map<String, dynamic> json) =>
      GetLeaderBoardModel(
        respCode: json["respCode"],
        message: json["message"],
        pointsList: json["pointsList"] == null
            ? []
            : List<PointsList>.from(
                json["pointsList"]!.map((x) => PointsList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "respCode": respCode,
        "message": message,
        "pointsList": pointsList == null
            ? []
            : List<dynamic>.from(pointsList!.map((x) => x.toJson())),
      };
}

class PointsList {
  String? msisdn;
  String? rewardPoints;
  String? rank;

  PointsList({
    this.msisdn,
    this.rewardPoints,
    this.rank,
  });

  factory PointsList.fromJson(Map<String, dynamic> json) => PointsList(
        msisdn: json["msisdn"],
        rewardPoints: json["rewardPoints"],
        rank: json["rank"],
      );

  Map<String, dynamic> toJson() => {
        "msisdn": msisdn,
        "rewardPoints": rewardPoints,
        "rank": rank,
      };
}
