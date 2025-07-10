import 'dart:convert';

// To parse this JSON data, do
//
//     final musicBoxScModel = musicBoxScModelFromJson(jsonString);

MusicBoxScModel musicBoxScModelFromJson(String str) =>
    MusicBoxScModel.fromJson(json.decode(str));

String musicBoxScModelToJson(MusicBoxScModel data) =>
    json.encode(data.toJson());

class MusicBoxScModel {
  int? respCode;
  String? message;
  DateTime? respTime;
  List<MusicBoxList>? musicBoxList;

  MusicBoxScModel({
    this.respCode,
    this.message,
    this.respTime,
    this.musicBoxList,
  });

  factory MusicBoxScModel.fromJson(Map<String, dynamic> json) =>
      MusicBoxScModel(
        respCode: json["respCode"],
        message: json["message"],
        respTime:
            json["respTime"] == null ? null : DateTime.parse(json["respTime"]),
        musicBoxList: json["musicBoxList"] == null
            ? []
            : List<MusicBoxList>.from(
                json["musicBoxList"]!.map((x) => MusicBoxList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "respCode": respCode,
        "message": message,
        "respTime": respTime?.toIso8601String(),
        "musicBoxList": musicBoxList == null
            ? []
            : List<dynamic>.from(musicBoxList!.map((x) => x.toJson())),
      };
}

class MusicBoxList {
  String? musicBoxId;
  String? musicBoxName;
  String? musicBoxIdpreviewImageUrl;

  MusicBoxList({
    this.musicBoxId,
    this.musicBoxName,
    this.musicBoxIdpreviewImageUrl,
  });

  factory MusicBoxList.fromJson(Map<String, dynamic> json) => MusicBoxList(
        musicBoxId: json["musicBoxId"],
        musicBoxName: json["musicBoxName"],
        musicBoxIdpreviewImageUrl: json["musicBoxIdpreviewImageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "musicBoxId": musicBoxId,
        "musicBoxName": musicBoxName,
        "musicBoxIdpreviewImageUrl": musicBoxIdpreviewImageUrl,
      };
}

/*
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
*/
