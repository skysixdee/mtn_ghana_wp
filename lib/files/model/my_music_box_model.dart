// To parse this JSON data, do
//
//     final myMusicBoxModel = myMusicBoxModelFromJson(jsonString);

import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/tune_info.dart';

MyMusicBoxModel myMusicBoxModelFromJson(String str) =>
    MyMusicBoxModel.fromJson(json.decode(str));

String myMusicBoxModelToJson(MyMusicBoxModel data) =>
    json.encode(data.toJson());

class MyMusicBoxModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  MyMusicBoxModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory MyMusicBoxModel.fromJson(Map<String, dynamic> json) =>
      MyMusicBoxModel(
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
  List<ListToneApk>? listToneApk;

  ResponseMap({
    this.listToneApk,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        listToneApk: json["listToneApk"] == null
            ? []
            : List<ListToneApk>.from(
                json["listToneApk"]!.map((x) => ListToneApk.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "listToneApk": listToneApk == null
            ? []
            : List<dynamic>.from(listToneApk!.map((x) => x.toJson())),
      };
}

class ListToneApk {
  List<TuneInfo>? toneDetails;
  String? serviceName;
  int? groupId;

  ListToneApk({
    this.toneDetails,
    this.serviceName,
    this.groupId,
  });

  factory ListToneApk.fromJson(Map<String, dynamic> json) => ListToneApk(
        toneDetails: json["toneDetails"] == null
            ? []
            : List<TuneInfo>.from(
                json["toneDetails"]!.map((x) => TuneInfo.fromJson(x))),
        serviceName: json["serviceName"],
        groupId: json["groupId"],
      );

  Map<String, dynamic> toJson() => {
        "toneDetails": toneDetails == null
            ? []
            : List<dynamic>.from(toneDetails!.map((x) => x.toJson())),
        "serviceName": serviceName,
        "groupId": groupId,
      };
}
/*
class ToneDetail {
    String? toneId;
    String? toneName;
    int? price;
    String? createdDate;
    String? status;
    String? toneIdStreamingUrl;
    String? toneIdpreviewImageUrl;

    ToneDetail({
        this.toneId,
        this.toneName,
        this.price,
        this.createdDate,
        this.status,
        this.toneIdStreamingUrl,
        this.toneIdpreviewImageUrl,
    });

    factory ToneDetail.fromJson(Map<String, dynamic> json) => ToneDetail(
        toneId: json["toneId"],
        toneName: json["toneName"],
        price: json["price"],
        createdDate: json["createdDate"],
        status: json["status"],
        toneIdStreamingUrl: json["toneIdStreamingUrl"],
        toneIdpreviewImageUrl: json["toneIdpreviewImageUrl"],
    );

    Map<String, dynamic> toJson() => {
        "toneId": toneId,
        "toneName": toneName,
        "price": price,
        "createdDate": createdDate,
        "status": status,
        "toneIdStreamingUrl": toneIdStreamingUrl,
        "toneIdpreviewImageUrl": toneIdpreviewImageUrl,
    };
}
*/