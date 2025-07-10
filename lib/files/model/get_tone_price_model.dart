// To parse this JSON data, do
//
//     final getTonePriceModell = getTonePriceModellFromJson(jsonString);
// To parse this JSON data, do
//
//     final getTonePriceModel = getTonePriceModelFromJson(jsonString);

import 'dart:convert';

GetTonePriceModel getTonePriceModelFromJson(String str) =>
    GetTonePriceModel.fromJson(json.decode(str));

String getTonePriceModelToJson(GetTonePriceModel data) =>
    json.encode(data.toJson());

class GetTonePriceModel {
  int? respCode;
  String? message;
  ContentDetails? contentDetails;

  GetTonePriceModel({
    this.respCode,
    this.message,
    this.contentDetails,
  });

  factory GetTonePriceModel.fromJson(Map<String, dynamic> json) =>
      GetTonePriceModel(
        respCode: json["respCode"],
        message: json["message"],
        contentDetails: json["contentDetails"] == null
            ? null
            : ContentDetails.fromJson(json["contentDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "respCode": respCode,
        "message": message,
        "contentDetails": contentDetails?.toJson(),
      };
}

class ContentDetails {
  String? offerName;
  String? offerStatus;
  int? contentPrice;

  ContentDetails({
    this.offerName,
    this.offerStatus,
    this.contentPrice,
  });

  factory ContentDetails.fromJson(Map<String, dynamic> json) => ContentDetails(
        offerName: json["offerName"],
        offerStatus: json["offerStatus"],
        contentPrice: json["contentPrice"],
      );

  Map<String, dynamic> toJson() => {
        "offerName": offerName,
        "offerStatus": offerStatus,
        "contentPrice": contentPrice,
      };
}

/*
import 'dart:convert';

GetTonePriceModell getTonePriceModellFromJson(String str) =>
    GetTonePriceModell.fromJson(json.decode(str));

String getTonePriceModellToJson(GetTonePriceModell data) =>
    json.encode(data.toJson());

class GetTonePriceModell {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  GetTonePriceModell({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory GetTonePriceModell.fromJson(Map<String, dynamic> json) =>
      GetTonePriceModell(
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
  String? feature;
  String? aPartyMsisdn;
  List<ResponseDetail>? responseDetails;
  String? description;
  String? responseTxnId;

  ResponseMap({
    this.feature,
    this.aPartyMsisdn,
    this.responseDetails,
    this.description,
    this.responseTxnId,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        feature: json["feature"],
        aPartyMsisdn: json["aPartyMsisdn"],
        responseDetails: json["responseDetails"] == null
            ? []
            : List<ResponseDetail>.from(json["responseDetails"]!
                .map((x) => ResponseDetail.fromJson(x))),
        description: json["description"],
        responseTxnId: json["responseTxnId"],
      );

  Map<String, dynamic> toJson() => {
        "feature": feature,
        "aPartyMsisdn": aPartyMsisdn,
        "responseDetails": responseDetails == null
            ? []
            : List<dynamic>.from(responseDetails!.map((x) => x.toJson())),
        "description": description,
        "responseTxnId": responseTxnId,
      };
}

class ResponseDetail {
  String? amount;
  String? languageId;
  String? packName;
  String? statusCodes;
  String? statusDesc;
  String? toneId;
  String? subscriberStatus;

  ResponseDetail({
    this.amount,
    this.languageId,
    this.packName,
    this.statusCodes,
    this.statusDesc,
    this.toneId,
    this.subscriberStatus,
  });

  factory ResponseDetail.fromJson(Map<String, dynamic> json) => ResponseDetail(
        amount: json["amount"],
        languageId: json["languageId"],
        packName: json["packName"],
        statusCodes: json["statusCodes"],
        statusDesc: json["statusDesc"],
        toneId: json["toneId"],
        subscriberStatus: json["subscriberStatus"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "languageId": languageId,
        "packName": packName,
        "statusCodes": statusCodes,
        "statusDesc": statusDesc,
        "toneId": toneId,
        "subscriberStatus": subscriberStatus,
      };
}

*/
/*
import 'dart:convert';

GetTonePriceModell getTonePriceModelFromJson(String str) => GetTonePriceModell.fromJson(json.decode(str));

String getTonePriceModelToJson(GetTonePriceModell data) => json.encode(data.toJson());

class GetTonePriceModell {
    GetTonePriceModell({
        required this.responseMap,
        required this.message,
        required this.respTime,
        required this.statusCode,
    });

    ResponseMap responseMap;
    String message;
    String respTime;
    String statusCode;

    factory GetTonePriceModell.fromJson(Map<String, dynamic> json) => GetTonePriceModell(
        responseMap: ResponseMap.fromJson(json["responseMap"]),
        message: json["message"],
        respTime: json["respTime"],
        statusCode: json["statusCode"],
    );

    Map<String, dynamic> toJson() => {
        "responseMap": responseMap.toJson(),
        "message": message,
        "respTime": respTime,
        "statusCode": statusCode,
    };
}

class ResponseMap {
    ResponseMap({
        required this.feature,
        required this.responseDetails,
        required this.description,
        required this.responseTxnId,
    });

    String feature;
    List<ResponseDetail> responseDetails;
    String description;
    String responseTxnId;

    factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        feature: json["feature"],
        responseDetails: List<ResponseDetail>.from(json["responseDetails"].map((x) => ResponseDetail.fromJson(x))),
        description: json["description"],
        responseTxnId: json["responseTxnId"],
    );

    Map<String, dynamic> toJson() => {
        "feature": feature,
        "responseDetails": List<dynamic>.from(responseDetails.map((x) => x.toJson())),
        "description": description,
        "responseTxnId": responseTxnId,
    };
}

class ResponseDetail {
    ResponseDetail({
        required this.amount,
        required this.languageId,
        required this.packName,
        required this.statusCodes,
        required this.statusDesc,
        required this.toneId,
        required this.bPartyMsisdn,
        required this.subscriberStatus,
    });

    String amount;
    String languageId;
    String packName;
    String statusCodes;
    String statusDesc;
    String toneId;
    String bPartyMsisdn;
    String subscriberStatus;

    factory ResponseDetail.fromJson(Map<String, dynamic> json) => ResponseDetail(
        amount: json["amount"],
        languageId: json["languageId"],
        packName: json["packName"],
        statusCodes: json["statusCodes"],
        statusDesc: json["statusDesc"],
        toneId: json["toneId"],
        bPartyMsisdn: json["bPartyMsisdn"],
        subscriberStatus: json["subscriberStatus"],
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "languageId": languageId,
        "packName": packName,
        "statusCodes": statusCodes,
        "statusDesc": statusDesc,
        "toneId": toneId,
        "bPartyMsisdn": bPartyMsisdn,
        "subscriberStatus": subscriberStatus,
    };
}
*/
