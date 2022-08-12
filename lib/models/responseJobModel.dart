// To parse this JSON data, do
//
//     final responseJobModel = responseJobModelFromJson(jsonString);

import 'dart:convert';

ResponseJobModel responseJobModelFromJson(String str) => ResponseJobModel.fromJson(json.decode(str));

String responseJobModelToJson(ResponseJobModel data) => json.encode(data.toJson());

class ResponseJobModel {
    ResponseJobModel({
        required this.responseCode,
        required this.responseMsg,
        required this.jobslist,
    });

    int responseCode;
    String responseMsg;
    List<Jobslist> jobslist;

    factory ResponseJobModel.fromJson(Map<String, dynamic> json) => ResponseJobModel(
        responseCode: json["responseCode"],
        responseMsg: json["responseMsg"],
        jobslist: List<Jobslist>.from(json["jobslist"].map((x) => Jobslist.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "responseMsg": responseMsg,
        "jobslist": List<dynamic>.from(jobslist.map((x) => x.toJson())),
    };
}

class Jobslist {
    Jobslist({
        required this.baslik,
        required this.detay,
        required this.gun,
        required this.harcananSure,
        required this.musteri,
        required this.durum,
        required this.oncelik,
    });

    String baslik;
    String detay;
    DateTime gun;
    int harcananSure;
    String musteri;
    String durum;
    String oncelik;

    factory Jobslist.fromJson(Map<String, dynamic> json) => Jobslist(
        baslik: json["baslik"],
        detay: json["detay"],
        gun: DateTime.parse(json["gun"]),
        harcananSure: json["harcananSure"],
        musteri: json["musteri"],
        durum: json["durum"],
        oncelik: json["oncelik"],
    );

    Map<String, dynamic> toJson() => {
        "baslik": baslik,
        "detay": detay,
        "gun": gun.toIso8601String(),
        "harcananSure": harcananSure,
        "musteri": musteri,
        "durum": durum,
        "oncelik": oncelik,
    };
}
