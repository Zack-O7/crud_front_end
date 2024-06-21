import 'package:flutter/material.dart';

class CompanyDetailsModel {
  final String companyName;
  final String companyEmailId;
  final Image? logo;
  final String? website;

  CompanyDetailsModel(
      {required this.companyName,
      required this.companyEmailId,
      required this.logo,
      required this.website});
}
