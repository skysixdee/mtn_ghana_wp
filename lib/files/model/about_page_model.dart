// To parse this JSON data, do
//
//     final aboutPageModel = aboutPageModelFromJson(jsonString);

import 'dart:convert';

AboutPageModel aboutPageModelFromJson(String str) =>
    AboutPageModel.fromJson(json.decode(str));

String aboutPageModelToJson(AboutPageModel data) => json.encode(data.toJson());

class AboutPageModel {
  List<AboutList>? aboutList;

  AboutPageModel({
    this.aboutList,
  });

  factory AboutPageModel.fromJson(Map<String, dynamic> json) => AboutPageModel(
        aboutList: json["aboutList"] == null
            ? []
            : List<AboutList>.from(
                json["aboutList"]!.map((x) => AboutList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "aboutList": aboutList == null
            ? []
            : List<dynamic>.from(aboutList!.map((x) => x.toJson())),
      };
}

class AboutList {
  String? header;
  List<DataList>? dataList;

  AboutList({
    this.header,
    this.dataList,
  });

  factory AboutList.fromJson(Map<String, dynamic> json) => AboutList(
        header: json["header"],
        dataList: json["dataList"] == null
            ? []
            : List<DataList>.from(
                json["dataList"]!.map((x) => DataList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "header": header,
        "dataList": dataList == null
            ? []
            : List<dynamic>.from(dataList!.map((x) => x.toJson())),
      };
}

class DataList {
  List<Datum>? data;

  DataList({
    this.data,
  });

  factory DataList.fromJson(Map<String, dynamic> json) => DataList(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? iconName;
  String? iconTitle;
  String? text;

  Datum({
    this.iconName,
    this.iconTitle,
    this.text,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        iconName: json["icon_name"],
        iconTitle: json["icon_title"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "icon_name": iconName,
        "icon_title": iconTitle,
        "text": text,
      };
}
