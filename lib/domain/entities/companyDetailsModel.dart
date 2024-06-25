import 'dart:io';

class CompanyDetailsModel {
  final String companyName;
  final String companyEmailId;
  final File? logo;
  // final Uint8List? logo;
  final String? website;

  CompanyDetailsModel(
      {required this.companyName,
      required this.companyEmailId,
      required this.logo,
      required this.website});
}
