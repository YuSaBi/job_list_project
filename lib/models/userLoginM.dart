/*
// To parse this JSON data, do
//
//     final userLoginModelM = userLoginModelMFromJson(jsonString);

import 'dart:convert';

UserLoginModelM userLoginModelMFromJson(String str) => UserLoginModelM.fromJson(json.decode(str));

String userLoginModelMToJson(UserLoginModelM data) => json.encode(data.toJson());

class UserLoginModelM {
    UserLoginModelM({
        required this.userId,
        required this.responseCode,
        required this.responseMsg,
    });

    int userId;
    int responseCode;
    String responseMsg;

    factory UserLoginModelM.fromJson(Map<String, dynamic> json) => UserLoginModelM(
        userId: json["userID"],
        responseCode: json["responseCode"],
        responseMsg: json["responseMsg"],
    );

    Map<String, dynamic> toJson() => {
        "userID": userId,
        "responseCode": responseCode,
        "responseMsg": responseMsg,
    };
}
*/