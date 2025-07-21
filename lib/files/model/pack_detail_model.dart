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
  String? userPreferredLanguage;
  String? groupId;
  String? offerType;
  String? offerMode;
  String? chargeType;
  String? renewalAttemptDate;
  String? lastTransactionId;
  String? chargingResultCode;

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
    this.userPreferredLanguage,
    this.groupId,
    this.offerType,
    this.offerMode,
    this.chargeType,
    this.renewalAttemptDate,
    this.lastTransactionId,
    this.chargingResultCode,
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
        userPreferredLanguage: json["userPreferredLanguage"],
        groupId: json["groupId"],
        offerType: json["offerType"],
        offerMode: json["offerMode"],
        chargeType: json["chargeType"],
        renewalAttemptDate: json["renewalAttemptDate"],
        lastTransactionId: json["lastTransactionId"],
        chargingResultCode: json["chargingResultCode"],
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
        "userPreferredLanguage": userPreferredLanguage,
        "groupId": groupId,
        "offerType": offerType,
        "offerMode": offerMode,
        "chargeType": chargeType,
        "renewalAttemptDate": renewalAttemptDate,
        "lastTransactionId": lastTransactionId,
        "chargingResultCode": chargingResultCode,
      };
}
