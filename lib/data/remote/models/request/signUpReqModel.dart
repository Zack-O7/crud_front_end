// To parse this JSON data, do
//
//     final signUpReqModel = signUpReqModelFromJson(jsonString);

import 'dart:convert';

SignUpReqModel signUpReqModelFromJson(String str) =>
    SignUpReqModel.fromJson(json.decode(str));

String signUpReqModelToJson(SignUpReqModel data) => json.encode(data.toJson());

class SignUpReqModel {
  String firstName;
  String lastName;
  String email;
  String password;

  SignUpReqModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  factory SignUpReqModel.fromJson(Map<String, dynamic> json) => SignUpReqModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
      };
}
