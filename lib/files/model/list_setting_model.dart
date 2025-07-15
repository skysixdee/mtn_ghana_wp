// To parse this JSON data, do
//
//     final listSettingModel = listSettingModelFromJson(jsonString);

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
  String? contentId;
  String? defaultToneSelectionType;
  String? isServiceSuspended;
  String? isShuffleOn;
  String? serviceId;
  String? serviceName;
  dynamic activationChannel;
  String? albumName;
  String? albumNameL2;
  String? artistName;
  String? artistNameL2;
  String? contentName;
  String? contentNameL2;
  String? contentPreviewImageUrl;
  String? contentStreamingUrl;
  String? contentType;
  String? expiryDate;
  String? firstActivationDate;
  String? isContentPackage;
  String? isToneInShuffle;
  String? price;
  String? settingsId;
  String? status;
  String? bMsisdn;
  String? groupId;

  SettingsList({
    this.contentId,
    this.defaultToneSelectionType,
    this.isServiceSuspended,
    this.isShuffleOn,
    this.serviceId,
    this.serviceName,
    this.activationChannel,
    this.albumName,
    this.albumNameL2,
    this.artistName,
    this.artistNameL2,
    this.contentName,
    this.contentNameL2,
    this.contentPreviewImageUrl,
    this.contentStreamingUrl,
    this.contentType,
    this.expiryDate,
    this.firstActivationDate,
    this.isContentPackage,
    this.isToneInShuffle,
    this.price,
    this.settingsId,
    this.status,
    this.bMsisdn,
    this.groupId,
  });

  factory SettingsList.fromJson(Map<String, dynamic> json) => SettingsList(
        contentId: json["contentId"],
        defaultToneSelectionType: json["defaultToneSelectionType"],
        isServiceSuspended: json["isServiceSuspended"],
        isShuffleOn: json["isShuffleOn"],
        serviceId: json["serviceId"],
        serviceName: json["serviceName"],
        activationChannel: json["activationChannel"],
        albumName: json["albumName"],
        albumNameL2: json["albumName_L2"],
        artistName: json["artistName"],
        artistNameL2: json["artistName_L2"],
        contentName: json["contentName"],
        contentNameL2: json["contentName_L2"],
        contentPreviewImageUrl: json["contentPreviewImageURL"],
        contentStreamingUrl: json["contentStreamingURL"],
        contentType: json["contentType"],
        expiryDate: json["expiryDate"],
        firstActivationDate: json["firstActivationDate"],
        isContentPackage: json["isContentPackage"],
        isToneInShuffle: json["isToneInShuffle"],
        price: json["price"],
        settingsId: json["settingsId"],
        status: json["status"],
        bMsisdn: json["bMsisdn"],
        groupId: json["groupId"],
      );

  Map<String, dynamic> toJson() => {
        "contentId": contentId,
        "defaultToneSelectionType": defaultToneSelectionType,
        "isServiceSuspended": isServiceSuspended,
        "isShuffleOn": isShuffleOn,
        "serviceId": serviceId,
        "serviceName": serviceName,
        "activationChannel": activationChannel,
        "albumName": albumName,
        "albumName_L2": albumNameL2,
        "artistName": artistName,
        "artistName_L2": artistNameL2,
        "contentName": contentName,
        "contentName_L2": contentNameL2,
        "contentPreviewImageURL": contentPreviewImageUrl,
        "contentStreamingURL": contentStreamingUrl,
        "contentType": contentType,
        "expiryDate": expiryDate,
        "firstActivationDate": firstActivationDate,
        "isContentPackage": isContentPackage,
        "isToneInShuffle": isToneInShuffle,
        "price": price,
        "settingsId": settingsId,
        "status": status,
        "bMsisdn": bMsisdn,
        "groupId": groupId,
      };
}
