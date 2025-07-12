// To parse this JSON data, do
//
//     final myTunesModel = myTunesModelFromJson(jsonString);

import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/tune_info.dart';

// To parse this JSON data, do
//
//     final myTunesModel = myTunesModelFromJson(jsonString);

import 'dart:convert';

MyTunesModel myTunesModelFromJson(String str) =>
    MyTunesModel.fromJson(json.decode(str));

String myTunesModelToJson(MyTunesModel data) => json.encode(data.toJson());

class MyTunesModel {
  int? respCode;
  String? message;
  List<TuneInfo>? tonelist;

  MyTunesModel({
    this.respCode,
    this.message,
    this.tonelist,
  });

  factory MyTunesModel.fromJson(Map<String, dynamic> json) => MyTunesModel(
        respCode: json["respCode"],
        message: json["message"],
        tonelist: json["tonelist"] == null
            ? []
            : List<TuneInfo>.from(
                json["tonelist"]!.map((x) => TuneInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "respCode": respCode,
        "message": message,
        "tonelist": tonelist == null
            ? []
            : List<dynamic>.from(tonelist!.map((x) => x.toJson())),
      };
}
/*
class Tonelist {
    String? contentType;
    String? activationChannel;
    String? albumName;
    String? albumNameL2;
    String? artistName;
    String? artistNameL2;
    DateTime? chargedDate;
    String? contentId;
    String? contentName;
    String? contentNameL2;
    String? contentPreviewImageUrl;
    String? contentStreamingUrl;
    DateTime? expiryDate;
    DateTime? firstActivationDate;
    String? isContentPackage;
    String? languageCode;
    String? price;
    String? status;

    Tonelist({
        this.contentType,
        this.activationChannel,
        this.albumName,
        this.albumNameL2,
        this.artistName,
        this.artistNameL2,
        this.chargedDate,
        this.contentId,
        this.contentName,
        this.contentNameL2,
        this.contentPreviewImageUrl,
        this.contentStreamingUrl,
        this.expiryDate,
        this.firstActivationDate,
        this.isContentPackage,
        this.languageCode,
        this.price,
        this.status,
    });

    factory Tonelist.fromJson(Map<String, dynamic> json) => Tonelist(
        contentType: json["ContentType"],
        activationChannel: json["activationChannel"],
        albumName: json["albumName"],
        albumNameL2: json["albumName_L2"],
        artistName: json["artistName"],
        artistNameL2: json["artistName_L2"],
        chargedDate: json["chargedDate"] == null ? null : DateTime.parse(json["chargedDate"]),
        contentId: json["contentId"],
        contentName: json["contentName"],
        contentNameL2: json["contentName_L2"],
        contentPreviewImageUrl: json["contentPreviewImageURL"],
        contentStreamingUrl: json["contentStreamingURL"],
        expiryDate: json["expiryDate"] == null ? null : DateTime.parse(json["expiryDate"]),
        firstActivationDate: json["firstActivationDate"] == null ? null : DateTime.parse(json["firstActivationDate"]),
        isContentPackage: json["isContentPackage"],
        languageCode: json["languageCode"],
        price: json["price"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "ContentType": contentType,
        "activationChannel": activationChannel,
        "albumName": albumName,
        "albumName_L2": albumNameL2,
        "artistName": artistName,
        "artistName_L2": artistNameL2,
        "chargedDate": chargedDate?.toIso8601String(),
        "contentId": contentId,
        "contentName": contentName,
        "contentName_L2": contentNameL2,
        "contentPreviewImageURL": contentPreviewImageUrl,
        "contentStreamingURL": contentStreamingUrl,
        "expiryDate": expiryDate?.toIso8601String(),
        "firstActivationDate": firstActivationDate?.toIso8601String(),
        "isContentPackage": isContentPackage,
        "languageCode": languageCode,
        "price": price,
        "status": status,
    };
}
*/
/*
MyTunesModel myTunesModelFromJson(String str) =>
    MyTunesModel.fromJson(json.decode(str));

String myTunesModelToJson(MyTunesModel data) => json.encode(data.toJson());

class MyTunesModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  MyTunesModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory MyTunesModel.fromJson(Map<String, dynamic> json) => MyTunesModel(
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
*/
/*
class ToneDetail {
  String? toneId;
  String? toneUrl;
  String? previewImageUrl;
  int? price;
  String? createdDate;
  String? status;
  String? isCopy;
  String? isGift;
  String? toneIdStreamingUrl;
  String? toneIdpreviewImageUrl;

  ToneDetail({
    this.toneId,
    this.toneUrl,
    this.previewImageUrl,
    this.price,
    this.createdDate,
    this.status,
    this.isCopy,
    this.isGift,
    this.toneIdStreamingUrl,
    this.toneIdpreviewImageUrl,
  });

  factory ToneDetail.fromJson(Map<String, dynamic> json) => ToneDetail(
        toneId: json["toneId"],
        toneUrl: json["toneUrl"],
        previewImageUrl: json["previewImageUrl"],
        price: json["price"],
        createdDate: json["createdDate"],
        status: json["status"],
        isCopy: json["isCopy"],
        isGift: json["isGift"],
        toneIdStreamingUrl: json["toneIdStreamingUrl"],
        toneIdpreviewImageUrl: json["toneIdpreviewImageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "toneId": toneId,
        "toneUrl": toneUrl,
        "previewImageUrl": previewImageUrl,
        "price": price,
        "createdDate": createdDate,
        "status": status,
        "isCopy": isCopy,
        "isGift": isGift,
        "toneIdStreamingUrl": toneIdStreamingUrl,
        "toneIdpreviewImageUrl": toneIdpreviewImageUrl,
      };
}
*/
