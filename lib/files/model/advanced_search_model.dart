import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/tune_info.dart';

AdvancedSearchModal advancedSearchModalFromJson(String str) =>
    AdvancedSearchModal.fromJson(json.decode(str));

String advancedSearchModalToJson(AdvancedSearchModal data) =>
    json.encode(data.toJson());

class AdvancedSearchModal {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  AdvancedSearchModal({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory AdvancedSearchModal.fromJson(Map<String, dynamic> json) =>
      AdvancedSearchModal(
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
  List<TuneInfo>? toneList;
  int? resultCount;

  ResponseMap({
    this.toneList,
    this.resultCount,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        toneList: json["toneList"] == null
            ? []
            : List<TuneInfo>.from(
                json["toneList"]!.map((x) => TuneInfo.fromJson(x))),
        resultCount: json["resultCount"],
      );

  Map<String, dynamic> toJson() => {
        "toneList": toneList == null
            ? []
            : List<dynamic>.from(toneList!.map((x) => x.toJson())),
        "resultCount": resultCount,
      };
}
