// To parse this JSON data, do
//
//     final signUpResModel = signUpResModelFromJson(jsonString);

import 'dart:convert';

SignUpResModel signUpResModelFromJson(String str) =>
    SignUpResModel.fromJson(json.decode(str));

String signUpResModelToJson(SignUpResModel data) => json.encode(data.toJson());

class SignUpResModel {
  String status;
  String message;
  List<SignUpData> data;

  SignUpResModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SignUpResModel.fromJson(Map<String, dynamic> json) => SignUpResModel(
        status: json["status"],
        message: json["message"],
        data: List<SignUpData>.from(
            json["data"].map((x) => SignUpData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SignUpData {
  String statusMessage;
  String fullName;

  SignUpData({
    required this.statusMessage,
    required this.fullName,
  });

  factory SignUpData.fromJson(Map<String, dynamic> json) => SignUpData(
        statusMessage: json["statusMessage"],
        fullName: json["fullName"],
      );

  Map<String, dynamic> toJson() => {
        "statusMessage": statusMessage,
        "fullName": fullName,
      };
}
