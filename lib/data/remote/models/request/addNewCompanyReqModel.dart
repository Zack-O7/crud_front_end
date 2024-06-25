// To parse this JSON data, do
//
//     final addNewCompanyReqModel = addNewCompanyReqModelFromJson(jsonString);

import 'dart:convert';

AddNewCompanyReqModel addNewCompanyReqModelFromJson(String str) =>
    AddNewCompanyReqModel.fromJson(json.decode(str));

String addNewCompanyReqModelToJson(AddNewCompanyReqModel data) =>
    json.encode(data.toJson());

class AddNewCompanyReqModel {
  String companyName;
  String companyEmail;
  String logo;
  String website;

  AddNewCompanyReqModel({
    required this.companyName,
    required this.companyEmail,
    required this.logo,
    required this.website,
  });

  factory AddNewCompanyReqModel.fromJson(Map<String, dynamic> json) =>
      AddNewCompanyReqModel(
        companyName: json["companyName"],
        companyEmail: json["companyEmail"],
        logo: json["logo"],
        website: json["website"],
      );

  Map<String, dynamic> toJson() => {
        "companyName": companyName,
        "companyEmail": companyEmail,
        "logo": logo,
        "website": website,
      };
}
