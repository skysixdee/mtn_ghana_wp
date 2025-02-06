// To parse this JSON data, do
//
//     final termsAndConditionsModel = termsAndConditionsModelFromJson(jsonString);

import 'dart:convert';

TermsAndConditionsModel termsAndConditionsModelFromJson(String str) => TermsAndConditionsModel.fromJson(json.decode(str));

String termsAndConditionsModelToJson(TermsAndConditionsModel data) => json.encode(data.toJson());

class TermsAndConditionsModel {
    List<TermsconditionsList>? termsconditionsList;

    TermsAndConditionsModel({
        this.termsconditionsList,
    });

    factory TermsAndConditionsModel.fromJson(Map<String, dynamic> json) => TermsAndConditionsModel(
        termsconditionsList: json["termsconditionsList"] == null ? [] : List<TermsconditionsList>.from(json["termsconditionsList"]!.map((x) => TermsconditionsList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "termsconditionsList": termsconditionsList == null ? [] : List<dynamic>.from(termsconditionsList!.map((x) => x.toJson())),
    };
}

class TermsconditionsList {
    String? question;
    List<Answer>? answer;

    TermsconditionsList({
        this.question,
        this.answer,
    });

    factory TermsconditionsList.fromJson(Map<String, dynamic> json) => TermsconditionsList(
        question: json["question"],
        answer: json["answer"] == null ? [] : List<Answer>.from(json["answer"]!.map((x) => Answer.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer == null ? [] : List<dynamic>.from(answer!.map((x) => x.toJson())),
    };
}

class Answer {
    String? header;
    String? subHeader;
    List<DataList>? dataList;

    Answer({
        this.header,
        this.subHeader,
        this.dataList,
    });

    factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        header: json["header"],
        subHeader: json["subHeader"],
        dataList: json["dataList"] == null ? [] : List<DataList>.from(json["dataList"]!.map((x) => DataList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "header": header,
        "subHeader": subHeader,
        "dataList": dataList == null ? [] : List<dynamic>.from(dataList!.map((x) => x.toJson())),
    };
}

class DataList {
    List<Datum>? data;

    DataList({
        this.data,
    });

    factory DataList.fromJson(Map<String, dynamic> json) => DataList(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? text;
    Style? style;

    Datum({
        this.text,
        this.style,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        text: json["text"],
        style: json["style"] == null ? null : Style.fromJson(json["style"]),
    );

    Map<String, dynamic> toJson() => {
        "text": text,
        "style": style?.toJson(),
    };
}

class Style {
    String? fontStyle;
    int? fontWeight;
    String? textDecoration;

    Style({
        this.fontStyle,
        this.fontWeight,
        this.textDecoration,
    });

    factory Style.fromJson(Map<String, dynamic> json) => Style(
        fontStyle: json["fontStyle"],
        fontWeight: json["fontWeight"],
        textDecoration: json["textDecoration"],
    );

    Map<String, dynamic> toJson() => {
        "fontStyle": fontStyle,
        "fontWeight": fontWeight,
        "textDecoration": textDecoration,
    };
}


// // To parse this JSON data, do
// //
// //     final termsAndConditionsModel = termsAndConditionsModelFromJson(jsonString);

// import 'dart:convert';

// TermsAndConditionsModel termsAndConditionsModelFromJson(String str) => TermsAndConditionsModel.fromJson(json.decode(str));

// String termsAndConditionsModelToJson(TermsAndConditionsModel data) => json.encode(data.toJson());

// class TermsAndConditionsModel {
//     List<FaqList>? faqList;

//     TermsAndConditionsModel({
//         this.faqList,
//     });

//     factory TermsAndConditionsModel.fromJson(Map<String, dynamic> json) => TermsAndConditionsModel(
//         faqList: json["faqList"] == null ? [] : List<FaqList>.from(json["faqList"]!.map((x) => FaqList.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "faqList": faqList == null ? [] : List<dynamic>.from(faqList!.map((x) => x.toJson())),
//     };
// }

// class FaqList {
//     String? question;
//     List<Answer>? answer;

//     FaqList({
//         this.question,
//         this.answer,
//     });

//     factory FaqList.fromJson(Map<String, dynamic> json) => FaqList(
//         question: json["question"],
//         answer: json["answer"] == null ? [] : List<Answer>.from(json["answer"]!.map((x) => Answer.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "question": question,
//         "answer": answer == null ? [] : List<dynamic>.from(answer!.map((x) => x.toJson())),
//     };
// }

// class Answer {
//     String? header;
//     List<DataList>? dataList;

//     Answer({
//         this.header,
//         this.dataList,
//     });

//     factory Answer.fromJson(Map<String, dynamic> json) => Answer(
//         header: json["header"],
//         dataList: json["dataList"] == null ? [] : List<DataList>.from(json["dataList"]!.map((x) => DataList.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "header": header,
//         "dataList": dataList == null ? [] : List<dynamic>.from(dataList!.map((x) => x.toJson())),
//     };
// }

// class DataList {
//     List<Datum>? data;

//     DataList({
//         this.data,
//     });

//     factory DataList.fromJson(Map<String, dynamic> json) => DataList(
//         data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
//     };
// }

// class Datum {
//     String? text;
//     Style? style;

//     Datum({
//         this.text,
//         this.style,
//     });

//     factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         text: json["text"],
//         style: json["style"] == null ? null : Style.fromJson(json["style"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "text": text,
//         "style": style?.toJson(),
//     };
// }

// class Style {
//     String? fontStyle;
//     int? fontWeight;
//     String? textDecoration;

//     Style({
//         this.fontStyle,
//         this.fontWeight,
//         this.textDecoration,
//     });

//     factory Style.fromJson(Map<String, dynamic> json) => Style(
//         fontStyle: json["fontStyle"],
//         fontWeight: json["fontWeight"],
//         textDecoration: json["textDecoration"],
//     );

//     Map<String, dynamic> toJson() => {
//         "fontStyle": fontStyle,
//         "fontWeight": fontWeight,
//         "textDecoration": textDecoration,
//     };
// }

