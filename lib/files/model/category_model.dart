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

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
    String? respCode;
    String? message;
    ResponseMap? responseMap;

    CategoryModel({
        this.respCode,
        this.message,
        this.responseMap,
    });

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        respCode: json["respCode"],
        message: json["message"],
        responseMap: json["responseMap"] == null ? null : ResponseMap.fromJson(json["responseMap"]),
    );

    Map<String, dynamic> toJson() => {
        "respCode": respCode,
        "message": message,
        "responseMap": responseMap?.toJson(),
    };
}

class ResponseMap {
    List<Category>? categoryList;

    ResponseMap({
        this.categoryList,
    });

    factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        categoryList: json["categoryList"] == null ? [] : List<Category>.from(json["categoryList"]!.map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "categoryList": categoryList == null ? [] : List<dynamic>.from(categoryList!.map((x) => x.toJson())),
    };
}

class Category {
    String? language;
    String? categoryId;
    String? menuId;
    String? categoryName;
    String? menuImage;

    Category({
        this.language,
        this.categoryId,
        this.menuId,
        this.categoryName,
        this.menuImage,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        language: json["language"],
        categoryId: json["categoryID"],
        menuId: json["menuID"],
        categoryName: json["categoryName"],
        menuImage: json["menuImage"],
    );

    Map<String, dynamic> toJson() => {
        "language": language,
        "categoryID": categoryId,
        "menuID": menuId,
        "categoryName": categoryName,
        "menuImage": menuImage,
    };
}
