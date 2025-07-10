// To parse this JSON data, do
//
//     final buyToneModel = buyToneModelFromJson(jsonString);

import 'dart:convert';

BuyToneModel buyToneModelFromJson(String str) =>
    BuyToneModel.fromJson(json.decode(str));

String buyToneModelToJson(BuyToneModel data) => json.encode(data.toJson());

class BuyToneModel {
  int? respCode;
  String? message;

  BuyToneModel({
    this.respCode,
    this.message,
  });

  factory BuyToneModel.fromJson(Map<String, dynamic> json) => BuyToneModel(
        respCode: json["respCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "respCode": respCode,
        "message": message,
      };
}
