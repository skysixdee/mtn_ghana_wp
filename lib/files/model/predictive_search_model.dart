// To parse this JSON data, do
//
//     final predictSearchModel = predictSearchModelFromJson(jsonString);

import 'dart:convert';

String _searchKey = '';
PredictSearchModel predictSearchModelFromJson(String str, String searchKey) =>
    PredictSearchModel.fromJson(json.decode(str), searchKey);

String predictSearchModelToJson(PredictSearchModel data) =>
    json.encode(data.toJson());

class PredictSearchModel {
  ResponseHeader? responseHeader;
  Suggest? suggest;

  PredictSearchModel({
    this.responseHeader,
    this.suggest,
  });

  factory PredictSearchModel.fromJson(
      Map<String, dynamic> json, String searchKey) {
    _searchKey = searchKey;
    return PredictSearchModel(
      responseHeader: json["responseHeader"] == null
          ? null
          : ResponseHeader.fromJson(json["responseHeader"]),
      suggest:
          json["suggest"] == null ? null : Suggest.fromJson(json["suggest"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "responseHeader": responseHeader?.toJson(),
        "suggest": suggest?.toJson(),
      };
}

class ResponseHeader {
  bool? zkConnected;
  int? status;
  int? qTime;

  ResponseHeader({
    this.zkConnected,
    this.status,
    this.qTime,
  });

  factory ResponseHeader.fromJson(Map<String, dynamic> json) => ResponseHeader(
        zkConnected: json["zkConnected"],
        status: json["status"],
        qTime: json["QTime"],
      );

  Map<String, dynamic> toJson() => {
        "zkConnected": zkConnected,
        "status": status,
        "QTime": qTime,
      };
}

class Suggest {
  AutoCompleteSuggester? autoCompleteSuggester;

  Suggest({
    this.autoCompleteSuggester,
  });

  factory Suggest.fromJson(Map<String, dynamic> json) => Suggest(
        autoCompleteSuggester: json["autoCompleteSuggester"] == null
            ? null
            : AutoCompleteSuggester.fromJson(json["autoCompleteSuggester"]),
      );

  Map<String, dynamic> toJson() => {
        "autoCompleteSuggester": autoCompleteSuggester?.toJson(),
      };
}

class AutoCompleteSuggester {
  SearchKey? searchKey;

  AutoCompleteSuggester({
    this.searchKey,
  });

  factory AutoCompleteSuggester.fromJson(Map<String, dynamic> json) =>
      AutoCompleteSuggester(
        searchKey: json[_searchKey] == null
            ? null
            : SearchKey.fromJson(json[_searchKey]),
      );

  Map<String, dynamic> toJson() => {
        _searchKey: searchKey?.toJson(),
      };
}

class SearchKey {
  int? numFound;
  List<Suggestion>? suggestions;

  SearchKey({
    this.numFound,
    this.suggestions,
  });

  factory SearchKey.fromJson(Map<String, dynamic> json) => SearchKey(
        numFound: json["numFound"],
        suggestions: json["suggestions"] == null
            ? []
            : List<Suggestion>.from(
                json["suggestions"]!.map((x) => Suggestion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "numFound": numFound,
        "suggestions": suggestions == null
            ? []
            : List<dynamic>.from(suggestions!.map((x) => x.toJson())),
      };
}

class Suggestion {
  String? term;
  int? weight;
  String? payload;

  Suggestion({
    this.term,
    this.weight,
    this.payload,
  });

  factory Suggestion.fromJson(Map<String, dynamic> json) => Suggestion(
        term: json["term"],
        weight: json["weight"],
        payload: json["payload"],
      );

  Map<String, dynamic> toJson() => {
        "term": term,
        "weight": weight,
        "payload": payload,
      };
}
