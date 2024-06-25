import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../domain/entities/companyDetailsModel.dart';
import '../../../controllers/dashboardCtrl.dart';
import '../../../themes/app_colors.dart';

class UpdateCompanyDetails extends StatefulWidget {
  final int index;
  final CompanyDetailsModel company;
  const UpdateCompanyDetails(
      {super.key, required this.index, required this.company});

  @override
  State<UpdateCompanyDetails> createState() => _UpdateCompanyDetailsState();
}

class _UpdateCompanyDetailsState extends State<UpdateCompanyDetails> {
  final dashboardCtrl = Get.find<DashboardCtrl>();

  // dynamic selectedImage;
  File? selectedAndroidLogo;
  Uint8List selectedWebLogo = Uint8List(8);
  var companyLogo = Rxn<XFile>();

  Future<void> pickImage() async {
    if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var webLogoFile = await image.readAsBytes();
        setState(() {
          selectedWebLogo = webLogoFile;
          selectedAndroidLogo = File('a');
        });
      } else {
        print("No Image selected");
      }
    } else if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var androidLogoFile = File(image.path);
        setState(() {
          selectedAndroidLogo = androidLogoFile;
        });
      } else {
        print("No Image selected");
      }
    } else {
      print("Other Issue in Logo Upload Function");
    }
  }

  @override
  Widget build(BuildContext context) {
    final companyNameCtrl =
        TextEditingController(text: widget.company.companyName);
    final companyEmailCtrl =
        TextEditingController(text: widget.company.companyEmailId);
    // dynamic storedLogo = widget.company.logo;
    final websiteCtrl = TextEditingController(text: widget.company.website);

    // double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: AlertDialog(
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "UPDATE COMPANY DETAILS",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.05),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.cardLightGrey,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: companyNameCtrl,
                        decoration: InputDecoration(
                          labelText: 'Company Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: height * 0.02),
                        child: TextFormField(
                          controller: companyEmailCtrl,
                          decoration: InputDecoration(
                            labelText: 'E-Mail ID',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: height * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() async {
                                  pickImage();
                                });
                              },
                              child: Text((kIsWeb
                                      ? selectedWebLogo.isEmpty
                                      : selectedAndroidLogo == null)
                                  ? 'Select Logo'
                                  : "Change Logo"),
                            ),
                            selectedAndroidLogo == null
                                ? Icon(
                                    Icons.image,
                                    size: height * 0.1,
                                  )
                                : Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: height * 0.03,
                                    ),
                                    child: Container(
                                      width: 70,
                                      height: 70,
                                      child: kIsWeb
                                          ? Image.memory(selectedWebLogo,
                                              fit: BoxFit.cover)
                                          : Image.file(selectedAndroidLogo!,
                                              fit: BoxFit.cover),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      TextFormField(
                        controller: websiteCtrl,
                        decoration: InputDecoration(
                          labelText: 'Website',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: height * 0.05,
                          bottom: height * 0.01,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                Get.back();
                              },
                              child: Text('Cancel'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                // final updatedCompany = CompanyDetailsModel(
                                //   companyName: companyNameCtrl.text,
                                //   companyEmailId: companyEmailCtrl.text,
                                //   logo: (kIsWeb
                                //       ? selectedWebLogo
                                //       : selectedAndroidLogo),
                                //   website: websiteCtrl.text,
                                // );
                                // dashboardCtrl.updateCompany(
                                //     widget.index, updatedCompany);
                                Get.back();
                                companyNameCtrl.clear();
                                companyEmailCtrl.clear();
                                websiteCtrl.clear();
                                setState(() {
                                  selectedWebLogo.isEmpty;
                                  selectedAndroidLogo = null;
                                });
                              },
                              child: Text('Update'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
