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
  List<SettingsList>? settingsList;

  ListSettingModel({
    this.respCode,
    this.message,
    this.settingsList,
  });

  factory ListSettingModel.fromJson(Map<String, dynamic> json) =>
      ListSettingModel(
        respCode: json["respCode"],
        message: json["message"],
        settingsList: json["settingsList"] == null
            ? []
            : List<SettingsList>.from(
                json["settingsList"]!.map((x) => SettingsList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "respCode": respCode,
        "message": message,
        "settingsList": settingsList == null
            ? []
            : List<dynamic>.from(settingsList!.map((x) => x.toJson())),
      };
}

class SettingsList {
  String? activationChannel;
  String? albumName;
  String? albumNameL2;
  String? artistName;
  String? artistNameL2;
  String? contentId;
  String? contentName;
  String? contentNameL2;
  String? contentPreviewImageUrl;
  String? contentStreamingUrl;
  String? contentType;
  String? defaultToneSelectionType;
  DateTime? expiryDate;
  DateTime? firstActivationDate;
  String? isContentPackage;
  String? isServiceSuspended;
  String? isShuffleOn;
  String? price;
  String? serviceId;
  String? serviceName;
  String? status;
  String? isToneInShuffle;
  String? settingsId;

  SettingsList({
    this.activationChannel,
    this.albumName,
    this.albumNameL2,
    this.artistName,
    this.artistNameL2,
    this.contentId,
    this.contentName,
    this.contentNameL2,
    this.contentPreviewImageUrl,
    this.contentStreamingUrl,
    this.contentType,
    this.defaultToneSelectionType,
    this.expiryDate,
    this.firstActivationDate,
    this.isContentPackage,
    this.isServiceSuspended,
    this.isShuffleOn,
    this.price,
    this.serviceId,
    this.serviceName,
    this.status,
    this.isToneInShuffle,
    this.settingsId,
  });

  factory SettingsList.fromJson(Map<String, dynamic> json) => SettingsList(
        activationChannel: json["activationChannel"],
        albumName: json["albumName"],
        albumNameL2: json["albumName_L2"],
        artistName: json["artistName"],
        artistNameL2: json["artistName_L2"],
        contentId: json["contentId"],
        contentName: json["contentName"],
        contentNameL2: json["contentName_L2"],
        contentPreviewImageUrl: json["contentPreviewImageURL"],
        contentStreamingUrl: json["contentStreamingURL"],
        contentType: json["contentType"],
        defaultToneSelectionType: json["defaultToneSelectionType"],
        expiryDate: json["expiryDate"] == null
            ? null
            : DateTime.parse(json["expiryDate"]),
        firstActivationDate: json["firstActivationDate"] == null
            ? null
            : DateTime.parse(json["firstActivationDate"]),
        isContentPackage: json["isContentPackage"],
        isServiceSuspended: json["isServiceSuspended"],
        isShuffleOn: json["isShuffleOn"],
        price: json["price"],
        serviceId: json["serviceId"],
        serviceName: json["serviceName"],
        status: json["status"],
        isToneInShuffle: json["isToneInShuffle"],
        settingsId: json["settingsId"],
      );

  Map<String, dynamic> toJson() => {
        "activationChannel": activationChannel,
        "albumName": albumName,
        "albumName_L2": albumNameL2,
        "artistName": artistName,
        "artistName_L2": artistNameL2,
        "contentId": contentId,
        "contentName": contentName,
        "contentName_L2": contentNameL2,
        "contentPreviewImageURL": contentPreviewImageUrl,
        "contentStreamingURL": contentStreamingUrl,
        "contentType": contentType,
        "defaultToneSelectionType": defaultToneSelectionType,
        "expiryDate": expiryDate?.toIso8601String(),
        "firstActivationDate": firstActivationDate?.toIso8601String(),
        "isContentPackage": isContentPackage,
        "isServiceSuspended": isServiceSuspended,
        "isShuffleOn": isShuffleOn,
        "price": price,
        "serviceId": serviceId,
        "serviceName": serviceName,
        "status": status,
        "isToneInShuffle": isToneInShuffle,
        "settingsId": settingsId,
      };
}
