import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../domain/entities/companyDetailsModel.dart';
import '../../../controllers/dashboardCtrl.dart';

class CreateNewCompany extends StatefulWidget {
  const CreateNewCompany({super.key});

  @override
  State<CreateNewCompany> createState() => _CreateNewCompanyState();
}

class _CreateNewCompanyState extends State<CreateNewCompany> {
  final dashboardCtrl = Get.find<DashboardCtrl>();

  dynamic selectedImage;
  var companyLogo = Rxn<XFile>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              TextFormField(
                controller: dashboardCtrl.companyNameCtrl,
                decoration: InputDecoration(labelText: "Company Name"),
              ),
              TextFormField(
                controller: dashboardCtrl.companyEmailCtrl,
                decoration: InputDecoration(labelText: "Company E-Mail ID"),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      selectedImage = await pickImage();
                      setState(() {});
                    },
                    child: Text('Pick Logo'),
                  ),
                  if (selectedImage != null)
                    Container(
                      width: 50,
                      height: 50,
                      child: selectedImage is Uint8List
                          ? Image.memory(selectedImage, fit: BoxFit.cover)
                          : Image.file(selectedImage, fit: BoxFit.cover),
                    )
                ],
              ),
              TextFormField(
                controller: dashboardCtrl.websiteCtrl,
                decoration: InputDecoration(labelText: "Website"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white),
                onPressed: () {
                  final newCompany = CompanyDetailsModel(
                    companyName: dashboardCtrl.companyNameCtrl.text,
                    companyEmailId: dashboardCtrl.companyEmailCtrl.text,
                    logo: selectedImage,
                    website: dashboardCtrl.websiteCtrl.text,
                  );
                  // dashboardCtrl.addCompany(newCompany);
                  Get.back();
                  dashboardCtrl.companyNameCtrl.clear();
                  dashboardCtrl.companyEmailCtrl.clear();
                  dashboardCtrl.websiteCtrl.clear();
                  setState(() {
                    selectedImage = null; // Clear the selected image
                  });
                },
                child: Text("Create"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, foregroundColor: Colors.white),
                onPressed: () {
                  Get.back();
                },
                child: Text("Cancel"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<dynamic> pickImage() async {
    if (kIsWeb) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true,
      );

      if (result != null && result.files.first.bytes != null) {
        return result.files.first.bytes;
      }
    } else {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        companyLogo.value = image;
        return File(image.path);
      } else {
        print("No Image selected");
      }
    }
    return null;
  }
}
