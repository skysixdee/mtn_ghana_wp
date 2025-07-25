// To parse this JSON data, do
//
//     final myTunesModel = myTunesModelFromJson(jsonString);

import 'dart:convert';

import 'package:mtn_ghana_wp/files/model/tune_info.dart';

MyTunesModel myTunesModelFromJson(String str) =>
    MyTunesModel.fromJson(json.decode(str));

String myTunesModelToJson(MyTunesModel data) => json.encode(data.toJson());

class MyTunesModel {
  int? respCode;
  String? message;
  ResponseMap? responseMap;

  MyTunesModel({
    this.respCode,
    this.message,
    this.responseMap,
  });

  factory MyTunesModel.fromJson(Map<String, dynamic> json) => MyTunesModel(
        respCode: json["respCode"],
        message: json["message"],
        responseMap: json["responseMap"] == null
            ? null
            : ResponseMap.fromJson(json["responseMap"]),
      );

  Map<String, dynamic> toJson() => {
        "respCode": respCode,
        "message": message,
        "responseMap": responseMap?.toJson(),
      };
}

class ResponseMap {
  List<TuneInfo>? toneList;

  ResponseMap({
    this.toneList,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        toneList: json["toneList"] == null
            ? []
            : List<TuneInfo>.from(
                json["toneList"]!.map((x) => TuneInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "toneList": toneList == null
            ? []
            : List<dynamic>.from(toneList!.map((x) => x.toJson())),
      };
}

/*
class Tonelist {
  String? contentId;
  String? contentName;
  String? albumName;
  String? artistName;
  String? isContentPackage;
  String? contentType;
  String? contentStreamingUrl;
  String? contentPreviewImageUrl;
  String? status;
  String? firstActivationDate;
  String? price;
  int? activationChannel;
  String? expiryDate;

  Tonelist({
    this.contentId,
    this.contentName,
    this.albumName,
    this.artistName,
    this.isContentPackage,
    this.contentType,
    this.contentStreamingUrl,
    this.contentPreviewImageUrl,
    this.status,
    this.firstActivationDate,
    this.price,
    this.activationChannel,
    this.expiryDate,
  });

  factory Tonelist.fromJson(Map<String, dynamic> json) => Tonelist(
        contentId: json["contentId"],
        contentName: json["contentName"],
        albumName: json["albumName"],
        artistName: json["artistName"],
        isContentPackage: json["isContentPackage"],
        contentType: json["contentType"],
        contentStreamingUrl: json["contentStreamingURL"],
        contentPreviewImageUrl: json["contentPreviewImageURL"],
        status: json["status"],
        firstActivationDate: json["firstActivationDate"],
        price: json["price"],
        activationChannel: json["activationChannel"],
        expiryDate: json["expiryDate"],
      );

  Map<String, dynamic> toJson() => {
        "contentId": contentId,
        "contentName": contentName,
        "albumName": albumName,
        "artistName": artistName,
        "isContentPackage": isContentPackage,
        "contentType": contentType,
        "contentStreamingURL": contentStreamingUrl,
        "contentPreviewImageURL": contentPreviewImageUrl,
        "status": status,
        "firstActivationDate": firstActivationDate,
        "price": price,
        "activationChannel": activationChannel,
        "expiryDate": expiryDate,
      };
}
*/
/*
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
*/
