// // To parse this JSON data, do
// //
// //     final categoryModel = categoryModelFromJson(jsonString);

// import 'dart:convert';

// CategoryModel categoryModelFromJson(String str) =>
//     CategoryModel.fromJson(json.decode(str));

// String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

// class CategoryModel {
//   ResponseMap? responseMap;
//   String? message;
//   String? respTime;
//   String? statusCode;

//   CategoryModel({
//     this.responseMap,
//     this.message,
//     this.respTime,
//     this.statusCode,
//   });

//   factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
//         responseMap: json["responseMap"] == null
//             ? null
//             : ResponseMap.fromJson(json["responseMap"]),
//         message: json["message"],
//         respTime: json["respTime"],
//         statusCode: json["statusCode"],
//       );

//   Map<String, dynamic> toJson() => {
//         "responseMap": responseMap?.toJson(),
//         "message": message,
//         "respTime": respTime,
//         "statusCode": statusCode,
//       };
// }

// class ResponseMap {
//   List<Category>? categories;

//   ResponseMap({
//     this.categories,
//   });

//   factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
//         categories: json["categories"] == null
//             ? []
//             : List<Category>.from(
//                 json["categories"]!.map((x) => Category.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "categories": categories == null
//             ? []
//             : List<dynamic>.from(categories!.map((x) => x.toJson())),
//       };
// }

// class Category {
//   String? categoryId;
//   String? categoryName;
//   String? menuImagePath;
//   String? language;

//   Category({
//     this.categoryId,
//     this.categoryName,
//     this.menuImagePath,
//     this.language,
//   });

//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//         categoryId: json["categoryId"],
//         categoryName: json["categoryName"],
//         menuImagePath: json["menuImagePath"],
//         language: json["language"],
//       );

//   Map<String, dynamic> toJson() => {
//         "categoryId": categoryId,
//         "categoryName": categoryName,
//         "menuImagePath": menuImagePath,
//         "language": language,
//       };
// }

// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

// // To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);
// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  ResponseMap? responseMap;
  String? message;
  String? respCode;

  CategoryModel({
    this.responseMap,
    this.message,
    this.respCode,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        responseMap: json["responseMap"] == null
            ? null
            : ResponseMap.fromJson(json["responseMap"]),
        message: json["message"],
        respCode: json["respCode"],
      );

  Map<String, dynamic> toJson() => {
        "responseMap": responseMap?.toJson(),
        "message": message,
        "respCode": respCode,
      };
}

class ResponseMap {
  List<Category>? categoryList;

  ResponseMap({
    this.categoryList,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        categoryList: json["categoryList"] == null
            ? []
            : List<Category>.from(
                json["categoryList"]!.map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categoryList": categoryList == null
            ? []
            : List<dynamic>.from(categoryList!.map((x) => x.toJson())),
      };
}

class Category {
  String? categoryId;
  String? language;
  String? menuId;
  String? menuImage;
  String? categoryName;

  Category({
    this.categoryId,
    this.language,
    this.menuId,
    this.menuImage,
    this.categoryName,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["categoryId"] ?? json["categoryID"],
        language: json["language"],
        menuId: json["menuId"],
        menuImage: json["menuImage"],
        categoryName: json["categoryName"],
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "language": language,
        "menuId": menuId,
        "menuImage": menuImage,
        "categoryName": categoryName,
      };
}

/*
import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  CategoryModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
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
  List<Category>? categories;

  ResponseMap({
    this.categories,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"]!.map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}

class Category {
  String? categoryId;
  String? categoryName;
  String? menuImagePath;
  String? language;

  Category({
    this.categoryId,
    this.categoryName,
    this.menuImagePath,
    this.language,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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
*/
