import 'dart:convert';


GenerateOtpScModel scGenerateOtpModelFromJson(String str) =>
    GenerateOtpScModel.fromJson(json.decode(str));

String scGenerateOtpModelToJson(GenerateOtpScModel data) =>
    json.encode(data.toJson());

class GenerateOtpScModel {
  int? respCode;
  String? message;
  int? otpResendTimeout;
  String? userData;

  GenerateOtpScModel({
    this.respCode,
    this.message,
    this.otpResendTimeout,
    this.userData,
  });

  factory GenerateOtpScModel.fromJson(Map<String, dynamic> json) =>
      GenerateOtpScModel(
        respCode: json["respCode"],
        message: json["message"],
        otpResendTimeout: json["otpResendTimeout"],
        userData: json["userData"],
      );

  Map<String, dynamic> toJson() => {
        "respCode": respCode,
        "message": message,
        "otpResendTimeout": otpResendTimeout,
        "userData": userData,
      };
}