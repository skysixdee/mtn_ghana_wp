// To parse this JSON data, do
//
//     final categoryMwModel = categoryMwModelFromJson(jsonString);

import 'dart:convert';

CategoryMwModel categoryMwModelFromJson(String str) => CategoryMwModel.fromJson(json.decode(str));

String categoryMwModelToJson(CategoryMwModel data) => json.encode(data.toJson());

class CategoryMwModel {
    ResponseMap? responseMap;
    String? message;
    String? respTime;
    String? statusCode;

    CategoryMwModel({
        this.responseMap,
        this.message,
        this.respTime,
        this.statusCode,
    });

    factory CategoryMwModel.fromJson(Map<String, dynamic> json) => CategoryMwModel(
        responseMap: json["responseMap"] == null ? null : ResponseMap.fromJson(json["responseMap"]),
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
    List<CategoryMw>? categories;

    ResponseMap({
        this.categories,
    });

    factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        categories: json["categories"] == null ? [] : List<CategoryMw>.from(json["categories"]!.map((x) => CategoryMw.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    };
}

class CategoryMw {
    String? categoryId;
    String? categoryName;
    String? menuImagePath;
    String? language;

    CategoryMw({
        this.categoryId,
        this.categoryName,
        this.menuImagePath,
        this.language,
    });

    factory CategoryMw.fromJson(Map<String, dynamic> json) => CategoryMw(
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        menuImagePath: json["menuImagePath"],
        language: json["language"],
    );

    Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
        "menuImagePath": menuImagePath,
        "language": language,
    };
}