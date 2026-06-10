// To parse this JSON data, do
//
//     final moodsListModel = moodsListModelFromJson(jsonString);

import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/tune_info.dart';

MoodsListModel moodsListModelFromJson(String str) =>
    MoodsListModel.fromJson(json.decode(str));

String moodsListModelToJson(MoodsListModel data) => json.encode(data.toJson());

class MoodsListModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  MoodsListModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory MoodsListModel.fromJson(Map<String, dynamic> json) => MoodsListModel(
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
  List<TuneInfo>? searchList;
  int? totalCount;

  ResponseMap({
    this.searchList,
    this.totalCount,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        searchList: json["searchList"] == null
            ? []
            : List<TuneInfo>.from(
                json["searchList"]!.map((x) => TuneInfo.fromJson(x))),
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "searchList": searchList == null
            ? []
            : List<dynamic>.from(searchList!.map((x) => x.toJson())),
        "totalCount": totalCount,
      };
}
