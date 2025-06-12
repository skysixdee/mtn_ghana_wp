import 'dart:convert';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';

MusicBoxScModel musicBoxModelScFromJson(String str) =>
    MusicBoxScModel.fromJson(json.decode(str));

String musicBoxModelScToJson(MusicBoxScModel data) =>
    json.encode(data.toJson());

class MusicBoxScModel {
  int? respCode;
  String? message;
  List<TuneInfo>? tonelist;

  MusicBoxScModel({
    this.respCode,
    this.message,
    this.tonelist,
  });

  factory MusicBoxScModel.fromJson(Map<String, dynamic> json) => MusicBoxScModel(
        respCode: json["respCode"],
        message: json["message"],
        tonelist: json["tonelist"] == null
            ? []
            : List<TuneInfo>.from(
                json["tonelist"].map((x) => TuneInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "respCode": respCode,
        "message": message,
        "tonelist":
            tonelist?.map((x) => x.toJson()).toList() ?? [],
      };
}
