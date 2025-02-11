import 'dart:convert';

GetTonePriceModel getTonePriceModelFromJson(String str) => GetTonePriceModel.fromJson(json.decode(str));

String getTonePriceModelToJson(GetTonePriceModel data) => json.encode(data.toJson());

class GetTonePriceModel {
    GetTonePriceModel({
        required this.responseMap,
        required this.message,
        required this.respTime,
        required this.statusCode,
    });

    ResponseMap responseMap;
    String message;
    String respTime;
    String statusCode;

    factory GetTonePriceModel.fromJson(Map<String, dynamic> json) => GetTonePriceModel(
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
