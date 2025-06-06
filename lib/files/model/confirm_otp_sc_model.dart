// To parse this JSON data, do
//
//     final confirmScOtpModel = confirmScOtpModelFromJson(jsonString);

import 'dart:convert';

ConfirmOtpScModel confirmScOtpModelFromJson(String str) =>
    ConfirmOtpScModel.fromJson(json.decode(str));

String confirmScOtpModelToJson(ConfirmOtpScModel data) =>
    json.encode(data.toJson());

class ConfirmOtpScModel {
  int? respCode;
  String? message;
  String? accessToken;
  String? refreshToken;
  int? expiresIn;

  ConfirmOtpScModel({
    this.respCode,
    this.message,
    this.accessToken,
    this.refreshToken,
    this.expiresIn,
  });

  factory ConfirmOtpScModel.fromJson(Map<String, dynamic> json) =>
      ConfirmOtpScModel(
        respCode: json["respCode"],
        message: json["message"],
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        expiresIn: json["expiresIn"],
      );

  Map<String, dynamic> toJson() => {
        "respCode": respCode,
        "message": message,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "expiresIn": expiresIn,
      };
}
