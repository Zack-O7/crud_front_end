// To parse this JSON data, do
//
//     final getAllUsersResModel = getAllUsersResModelFromJson(jsonString);

import 'dart:convert';

GetAllUsersResModel getAllUsersResModelFromJson(String str) =>
    GetAllUsersResModel.fromJson(json.decode(str));

String getAllUsersResModelToJson(GetAllUsersResModel data) =>
    json.encode(data.toJson());

class GetAllUsersResModel {
  String status;
  String message;
  List<GetAllUsersData> data;

  GetAllUsersResModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetAllUsersResModel.fromJson(Map<String, dynamic> json) =>
      GetAllUsersResModel(
        status: json["status"],
        message: json["message"],
        data: List<GetAllUsersData>.from(
            json["data"].map((x) => GetAllUsersData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetAllUsersData {
  int id;
  String firstName;
  String lastName;
  String email;
  String password;

  GetAllUsersData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  factory GetAllUsersData.fromJson(Map<String, dynamic> json) =>
      GetAllUsersData(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
      };
}
