// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
    LoginResponseModel({
        required this.userId,
        required this.responseCode,
        required this.responseMsg,
    });

    int userId;
    int responseCode;
    String responseMsg;

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
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
