import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../domain/entities/companyDetailsModel.dart';
import '../../../controllers/dashboardCtrl.dart';
import '../../../themes/app_colors.dart';

class CreateNewCompany extends StatefulWidget {
  const CreateNewCompany({super.key});

  @override
  State<CreateNewCompany> createState() => _CreateNewCompanyState();
}

class _CreateNewCompanyState extends State<CreateNewCompany> {
  final dashboardCtrl = Get.find<DashboardCtrl>();

  // File? selectedAndroidLogo;
  // Uint8List selectedWebLogo = Uint8List(8);
  // var companyLogo = Rxn<XFile>();

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    // if (kIsWeb) {
    //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    //   if (image != null) {
    //     var webLogoFile = await image.readAsBytes();
    //     setState(() {
    //       dashboardCtrl.selectedWebLogo = webLogoFile;
    //       dashboardCtrl.selectedAndroidLogo = null;
    //     });
    //   } else {
    //     print("No Image selected");
    //   }
    // } else if (!kIsWeb) {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var androidLogoFile = File(image.path);
      // var androidLogoBytes = await androidLogoFile.readAsBytes();
      setState(() {
        dashboardCtrl.selectedAndroidLogo = androidLogoFile;
        dashboardCtrl.selectedWebLogo = null;
      });
    } else {
      print("No Image selected");
    }
    // } else {
    //   print("Other Issue in Logo Upload Function");
    // }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: AlertDialog(
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "ADD NEW COMPANY",
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
                        controller: dashboardCtrl.companyNameCtrl,
                        decoration: InputDecoration(
                          labelText: "Company Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: height * 0.02),
                        child: TextFormField(
                          controller: dashboardCtrl.companyEmailCtrl,
                          decoration: InputDecoration(
                            labelText: "Company E-Mail ID",
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
                                pickImage();
                              },
                              // child: Text((kIsWeb
                              //         ? dashboardCtrl.selectedWebLogo!.isEmpty
                              //         : dashboardCtrl.selectedAndroidLogo ==
                              //             null)
                              child: Text(
                                  dashboardCtrl.selectedAndroidLogo == null
                                      ? 'Select Logo'
                                      : "Change Logo"),
                            ),
                            dashboardCtrl.selectedAndroidLogo == null
                                // || dashboardCtrl.selectedWebLogo!.isEmpty
                                ? Icon(
                                    Icons.image,
                                    size: height * 0.1,
                                  )
                                : Container(
                                    width: 70,
                                    height: 70,
                                    // child: kIsWeb
                                    //     ? Image.memory(
                                    //         dashboardCtrl.selectedWebLogo!,
                                    //         fit: BoxFit.cover)
                                    //     : Image.file(
                                    //         dashboardCtrl.selectedAndroidLogo!,
                                    //         fit: BoxFit.cover),
                                    child: Image.file(
                                        dashboardCtrl.selectedAndroidLogo!,
                                        fit: BoxFit.cover),
                                  ),
                            if (dashboardCtrl.fileName != null)
                              Text('Selected File: ${dashboardCtrl.fileName}'),
                          ],
                        ),
                      ),
                      TextFormField(
                        controller: dashboardCtrl.websiteCtrl,
                        decoration: InputDecoration(
                          labelText: "Website",
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
                                dashboardCtrl.companyNameCtrl.clear();
                                dashboardCtrl.companyEmailCtrl.clear();
                                dashboardCtrl.websiteCtrl.clear();
                                setState(() {
                                  // dashboardCtrl.selectedWebLogo!.isEmpty;
                                  dashboardCtrl.selectedAndroidLogo = null;
                                });
                              },
                              child: Text("Cancel"),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white),
                              onPressed: () async {
                                final newCompany = CompanyDetailsModel(
                                  companyName:
                                      dashboardCtrl.companyNameCtrl.text,
                                  companyEmailId:
                                      dashboardCtrl.companyEmailCtrl.text,
                                  // logo: kIsWeb
                                  //     ? dashboardCtrl.selectedWebLogo
                                  //     : dashboardCtrl.selectedAndroidLogo,
                                  logo: dashboardCtrl.selectedAndroidLogo,
                                  website: dashboardCtrl.websiteCtrl.text,
                                );
                                // dashboardCtrl.addCompany(newCompany);
                                await dashboardCtrl.addNewCompany(newCompany);

                                dashboardCtrl.companyNameCtrl.clear();
                                dashboardCtrl.companyEmailCtrl.clear();
                                dashboardCtrl.websiteCtrl.clear();
                                setState(() {
                                  // dashboardCtrl.selectedWebLogo = Uint8List(8);
                                  dashboardCtrl.selectedAndroidLogo = null;
                                });
                                Get.back();
                              },
                              child: Text("Create"),
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
