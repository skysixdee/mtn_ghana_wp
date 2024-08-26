// To parse this JSON data, do
//
//     final viewBlackListModel = viewBlackListModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

ViewBlackListModel viewBlackListModelFromJson(String str) =>
    ViewBlackListModel.fromJson(json.decode(str));

String viewBlackListModelToJson(ViewBlackListModel data) =>
    json.encode(data.toJson());

class ViewBlackListModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  ViewBlackListModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory ViewBlackListModel.fromJson(Map<String, dynamic> json) =>
      ViewBlackListModel(
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
  List<BPartyDetailsList>? bPartyDetailsList;
  String? responseMessage;
  String? transactionId;

  ResponseMap({
    this.bPartyDetailsList,
    this.responseMessage,
    this.transactionId,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        bPartyDetailsList: json["bPartyDetailsList"] == null
            ? []
            : List<BPartyDetailsList>.from(json["bPartyDetailsList"]!
                .map((x) => BPartyDetailsList.fromJson(x))),
        responseMessage: json["responseMessage"],
        transactionId: json["transactionId"],
      );

  Map<String, dynamic> toJson() => {
        "bPartyDetailsList": bPartyDetailsList == null
            ? []
            : List<dynamic>.from(bPartyDetailsList!.map((x) => x.toJson())),
        "responseMessage": responseMessage,
        "transactionId": transactionId,
      };
}

class BPartyDetailsList {
  String? serviceName;
  String? groupId;
  String? language;
  String? reverseSuspended;
  String? serialNo;
  String? suspended;
  String? bPartyMsisdn;
  String? bPartyName;
  RxBool isDeleting = false.obs;
  BPartyDetailsList({
    this.serviceName,
    this.groupId,
    this.language,
    this.reverseSuspended,
    this.serialNo,
    this.suspended,
    this.bPartyMsisdn,
    this.bPartyName,
  });

  factory BPartyDetailsList.fromJson(Map<String, dynamic> json) =>
      BPartyDetailsList(
        serviceName: json["serviceName"],
        groupId: json["groupId"],
        language: json["language"],
        reverseSuspended: json["reverseSuspended"],
        serialNo: json["serialNo"],
        suspended: json["suspended"],
        bPartyMsisdn: json["bPartyMsisdn"],
        bPartyName: json["bPartyName"],
      );

  Map<String, dynamic> toJson() => {
        "serviceName": serviceName,
        "groupId": groupId,
        "language": language,
        "reverseSuspended": reverseSuspended,
        "serialNo": serialNo,
        "suspended": suspended,
        "bPartyMsisdn": bPartyMsisdn,
        "bPartyName": bPartyName,
      };
}
