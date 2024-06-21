// To parse this JSON data, do
//
//     final signInResModel = signInResModelFromJson(jsonString);

import 'dart:convert';

SignInResModel signInResModelFromJson(String str) => SignInResModel.fromJson(json.decode(str));

String signInResModelToJson(SignInResModel data) => json.encode(data.toJson());

class SignInResModel {
    String status;
    String message;
    List<SignInResData> data;

    SignInResModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory SignInResModel.fromJson(Map<String, dynamic> json) => SignInResModel(
        status: json["status"],
        message: json["message"],
        data: List<SignInResData>.from(json["data"].map((x) => SignInResData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class SignInResData {
    String statusMessage;
    String firstName;
    String lastName;
    String email;

    SignInResData({
        required this.statusMessage,
        required this.firstName,
        required this.lastName,
        required this.email,
    });

    factory SignInResData.fromJson(Map<String, dynamic> json) => SignInResData(
        statusMessage: json["statusMessage"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "statusMessage": statusMessage,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
    };
}
