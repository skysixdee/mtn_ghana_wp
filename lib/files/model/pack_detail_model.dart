// To parse this JSON data, do
//
//     final packDetailModel = packDetailModelFromJson(jsonString);
// To parse this JSON data, do
//
//     final packDetailModel = packDetailModelFromJson(jsonString);

import 'dart:convert';

PackDetailModel packDetailModelFromJson(String str) =>
    PackDetailModel.fromJson(json.decode(str));

String packDetailModelToJson(PackDetailModel data) =>
    json.encode(data.toJson());

class PackDetailModel {
  String? msisdn;
  int? respCode;
  String? message;
  List<Offer>? offers;

  PackDetailModel({
    this.msisdn,
    this.respCode,
    this.message,
    this.offers,
  });

  factory PackDetailModel.fromJson(Map<String, dynamic> json) =>
      PackDetailModel(
        msisdn: json["msisdn"],
        respCode: json["respCode"],
        message: json["message"],
        offers: json["offers"] == null
            ? []
            : List<Offer>.from(json["offers"]!.map((x) => Offer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "msisdn": msisdn,
        "respCode": respCode,
        "message": message,
        "offers": offers == null
            ? []
            : List<dynamic>.from(offers!.map((x) => x.toJson())),
      };
}

class Offer {
  String? offerName;
  String? offerStatus;
  String? expiryDate;
  String? chargedAmount;
  String? chargedDate;
  String? chargedValidity;
  String? firstActivationDate;
  String? activationChannel;
  String? deactivationDate;
  String? deactivationChannel;

  Offer({
    this.offerName,
    this.offerStatus,
    this.expiryDate,
    this.chargedAmount,
    this.chargedDate,
    this.chargedValidity,
    this.firstActivationDate,
    this.activationChannel,
    this.deactivationDate,
    this.deactivationChannel,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        offerName: json["offerName"],
        offerStatus: json["offerStatus"],
        expiryDate: json["expiryDate"],
        chargedAmount: json["chargedAmount"],
        chargedDate: json["chargedDate"],
        chargedValidity: json["chargedValidity"],
        firstActivationDate: json["firstActivationDate"],
        activationChannel: json["activationChannel"],
        deactivationDate: json["deactivationDate"],
        deactivationChannel: json["deactivationChannel"],
      );

  Map<String, dynamic> toJson() => {
        "offerName": offerName,
        "offerStatus": offerStatus,
        "expiryDate": expiryDate,
        "chargedAmount": chargedAmount,
        "chargedDate": chargedDate,
        "chargedValidity": chargedValidity,
        "firstActivationDate": firstActivationDate,
        "activationChannel": activationChannel,
        "deactivationDate": deactivationDate,
        "deactivationChannel": deactivationChannel,
      };
}

/*
import 'dart:convert';

PackDetailModel packDetailModelFromJson(String str) =>
    PackDetailModel.fromJson(json.decode(str));

String packDetailModelToJson(PackDetailModel data) =>
    json.encode(data.toJson());

class PackDetailModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  PackDetailModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory PackDetailModel.fromJson(Map<String, dynamic> json) =>
      PackDetailModel(
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
  PackStatusDetails? packStatusDetails;

  ResponseMap({
    this.packStatusDetails,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        packStatusDetails: json["packStatusDetails"] == null
            ? null
            : PackStatusDetails.fromJson(json["packStatusDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "packStatusDetails": packStatusDetails?.toJson(),
      };
}

class PackStatusDetails {
  String? languageId;
  String? packName;

  PackStatusDetails({
    this.languageId,
    this.packName,
  });

  factory PackStatusDetails.fromJson(Map<String, dynamic> json) =>
      PackStatusDetails(
        languageId: json["languageId"],
        packName: json["packName"],
      );

  Map<String, dynamic> toJson() => {
        "languageId": languageId,
        "packName": packName,
      };
}
*/
