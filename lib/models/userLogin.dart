// To parse this JSON data, do
//
//     final userLoginModel = userLoginModelFromJson(jsonString);

import 'dart:convert';

UserLoginModel userLoginModelFromJson(String str) => UserLoginModel.fromJson(json.decode(str));

String userLoginModelToJson(UserLoginModel data) => json.encode(data.toJson());

class UserLoginModel {
    UserLoginModel({required this.responseMsg});

    String responseMsg;

    factory UserLoginModel.fromJson(Map<String, dynamic> json) => UserLoginModel(
        responseMsg: json["responseMsg"],
    );

    Map<String, dynamic> toJson() => {
        "responseMsg": responseMsg,
    };
}
