// To parse this JSON data, do
//
//     final addNewCompanyResModel = addNewCompanyResModelFromJson(jsonString);

import 'dart:convert';

AddNewCompanyResModel addNewCompanyResModelFromJson(String str) => AddNewCompanyResModel.fromJson(json.decode(str));

String addNewCompanyResModelToJson(AddNewCompanyResModel data) => json.encode(data.toJson());

class AddNewCompanyResModel {
    String status;
    String message;
    List<AddNewCompanyData> data;

    AddNewCompanyResModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory AddNewCompanyResModel.fromJson(Map<String, dynamic> json) => AddNewCompanyResModel(
        status: json["status"],
        message: json["message"],
        data: List<AddNewCompanyData>.from(json["data"].map((x) => AddNewCompanyData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class AddNewCompanyData {
    String statusMessage;
    int id;
    String companyName;

    AddNewCompanyData({
        required this.statusMessage,
        required this.id,
        required this.companyName,
    });

    factory AddNewCompanyData.fromJson(Map<String, dynamic> json) => AddNewCompanyData(
        statusMessage: json["statusMessage"],
        id: json["id"],
        companyName: json["companyName"],
    );

    Map<String, dynamic> toJson() => {
        "statusMessage": statusMessage,
        "id": id,
        "companyName": companyName,
    };
}
