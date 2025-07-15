// To parse this JSON data, do
//
//     final listSettingModel = listSettingModelFromJson(jsonString);

import 'dart:convert';

ListSettingModel listSettingModelFromJson(String str) =>
    ListSettingModel.fromJson(json.decode(str));

String listSettingModelToJson(ListSettingModel data) =>
    json.encode(data.toJson());

class ListSettingModel {
  int? respCode;
  String? message;
  List<Settingslist>? settingslist;

  ListSettingModel({
    this.respCode,
    this.message,
    this.settingslist,
  });

  factory ListSettingModel.fromJson(Map<String, dynamic> json) =>
      ListSettingModel(
        respCode: json["respCode"],
        message: json["message"],
        settingslist: json["settingslist"] == null
            ? []
            : List<Settingslist>.from(
                json["settingslist"]!.map((x) => Settingslist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "respCode": respCode,
        "message": message,
        "settingslist": settingslist == null
            ? []
            : List<dynamic>.from(settingslist!.map((x) => x.toJson())),
      };
}

class Settingslist {
  String? serviceId;
  String? serviceName;
  String? contentId;
  String? defaultToneSelectionType;
  String? isShuffleOn;
  String? isServiceSuspended;
  String? contentName;
  String? albumName;
  String? artistName;
  String? isContentPackage;
  String? contentType;
  String? contentStreamingUrl;
  String? contentPreviewImageUrl;
  String? status;
  DateTime? firstActivationDate;
  String? price;
  int? activationChannel;
  DateTime? expiryDate;
  String? bMsisdn;
  String? groupId;

  Settingslist({
    this.serviceId,
    this.serviceName,
    this.contentId,
    this.defaultToneSelectionType,
    this.isShuffleOn,
    this.isServiceSuspended,
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
    this.bMsisdn,
    this.groupId,
  });

  factory Settingslist.fromJson(Map<String, dynamic> json) => Settingslist(
        serviceId: json["serviceId"],
        serviceName: json["serviceName"],
        contentId: json["contentId"],
        defaultToneSelectionType: json["defaultToneSelectionType"],
        isShuffleOn: json["isShuffleOn"],
        isServiceSuspended: json["isServiceSuspended"],
        contentName: json["contentName"],
        albumName: json["albumName"],
        artistName: json["artistName"],
        isContentPackage: json["isContentPackage"],
        contentType: json["contentType"],
        contentStreamingUrl: json["contentStreamingURL"],
        contentPreviewImageUrl: json["contentPreviewImageURL"],
        status: json["status"],
        firstActivationDate: json["firstActivationDate"] == null
            ? null
            : DateTime.parse(json["firstActivationDate"]),
        price: json["price"],
        activationChannel: json["activationChannel"],
        expiryDate: json["expiryDate"] == null
            ? null
            : DateTime.parse(json["expiryDate"]),
        bMsisdn: json["bMsisdn"],
        groupId: json["groupId"],
      );

  Map<String, dynamic> toJson() => {
        "serviceId": serviceId,
        "serviceName": serviceName,
        "contentId": contentId,
        "defaultToneSelectionType": defaultToneSelectionType,
        "isShuffleOn": isShuffleOn,
        "isServiceSuspended": isServiceSuspended,
        "contentName": contentName,
        "albumName": albumName,
        "artistName": artistName,
        "isContentPackage": isContentPackage,
        "contentType": contentType,
        "contentStreamingURL": contentStreamingUrl,
        "contentPreviewImageURL": contentPreviewImageUrl,
        "status": status,
        "firstActivationDate": firstActivationDate?.toIso8601String(),
        "price": price,
        "activationChannel": activationChannel,
        "expiryDate": expiryDate?.toIso8601String(),
        "bMsisdn": bMsisdn,
        "groupId": groupId,
      };
}
