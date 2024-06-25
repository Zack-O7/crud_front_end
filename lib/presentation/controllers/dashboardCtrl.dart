import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:client/core/response_classify.dart';
import 'package:client/core/usecase.dart';
import 'package:client/data/remote/models/request/addNewCompanyReqModel.dart';
import 'package:client/data/remote/models/response/addNewCompanyResModel.dart';
import 'package:client/data/remote/models/response/getAllUsersResModel.dart';
import 'package:client/domain/entities/userDetailsModel.dart';
import 'package:client/domain/usecases/addNewCompanyUseCase.dart';
import 'package:client/domain/usecases/getAllUsersUseCase.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../domain/entities/companyDetailsModel.dart';
import '../../domain/entities/employeeDetailsModel.dart';
import '../widgets/snackBarMsg.dart';

class DashboardCtrl extends GetxController {
  final GetAllUsersUseCase getAllUsersUseCase;
  final AddNewCompanyUseCase addNewCompanyUseCase;

  DashboardCtrl(this.getAllUsersUseCase, this.addNewCompanyUseCase);

  ///User
  final userList = <UserDetailsModel>[
    UserDetailsModel("Adam", "John", "adam@gmail.com"),
    UserDetailsModel("John", "Cena", "cena@gmail.com"),
    UserDetailsModel("Brock", "Lesner", "brock@gmail.com"),
  ].obs;

  final getAllUsersList = <GetAllUsersData>[].obs;
  final getAllUsersState = ResponseClassify<GetAllUsersResModel>.error("").obs;

  getAllUsers() async {
    getAllUsersState.value = ResponseClassify.loading();
    try {
      // final response = await getAllUsersUseCase.call(NoParams());
      // final parsedResponse = getAllUsersResModelFromJson(response.toString());
      // getAllUsersState.value = ResponseClassify.completed(parsedResponse);
      getAllUsersState.value =
          ResponseClassify.completed(await getAllUsersUseCase.call(NoParams()));
      print("GetAllUsers API Completed");
      getAllUsersList.clear();
      getAllUsersList.addAll(getAllUsersState.value.data!.data);
      if (kDebugMode) {
        print("GetAllUsersList : $getAllUsersList");
        print("GetAllUsersList Length : ${getAllUsersList.length}");
      }
    } catch (e) {
      snackBarMsg("Failed", "$e", false);
      print("GetAllUsersList Error: ${e}");
      getAllUsersState.value = ResponseClassify.error("$e");
    }
  }

  ///Company
  final companyNameCtrl = TextEditingController();
  final companyEmailCtrl = TextEditingController();
  final websiteCtrl = TextEditingController();
  final companyList = <CompanyDetailsModel>[].obs;
  var logoPath = ''.obs;
  File? selectedAndroidLogo;
  // Uint8List? selectedAndroidLogo;
  Uint8List? selectedWebLogo = Uint8List(8);
  dio.MultipartFile? logoFile;
  String? fileName;
  String? logoBase64;

  ///Add New Company API
  final addNewCompanyList = <AddNewCompanyData>[].obs;
  final addNewCompanyState =
      ResponseClassify<AddNewCompanyResModel>.error("").obs;

  ///Method 1 Using body > FormData
  // addNewCompany(CompanyDetailsModel company) async {
  //   addNewCompanyState.value = ResponseClassify.loading();
  //   try {
  //     // if (selectedAndroidLogo != null || selectedWebLogo.isNotEmpty) {
  //     if (kIsWeb) {
  //       // For web
  //       // if (logoPath.value is Uint8List) {
  //       print("Selected Before Web File : $logoFile");
  //       logoFile = await dio.MultipartFile.fromBytes(
  //         selectedWebLogo!,
  //         filename: fileName,
  //       );
  //       print("Selected After Web File : $logoFile");
  //       // }
  //     } else {
  //       // For mobile
  //       // if (logoPath.value is String) {
  //       String filename = selectedAndroidLogo!.path.split('/').last;
  //       logoFile = await dio.MultipartFile.fromFile(
  //         selectedAndroidLogo!.path,
  //         filename: filename,
  //       );
  //       print("Selected Android File : $logoFile");
  //       // }
  //     }
  //     // }
  //
  //     var data = dio.FormData.fromMap({
  //       'companyName': companyNameCtrl.text,
  //       'companyEmail': companyEmailCtrl.text,
  //       'logo': [logoFile],
  //       // 'logo': kIsWeb
  //       //     ? await dio.MultipartFile.fromBytes(
  //       //         selectedWebLogo,
  //       //         filename: 'logo.jpg',
  //       //       )
  //       //     : await dio.MultipartFile.fromFile(
  //       //         selectedAndroidLogo!.path,
  //       //         // filename: 'logo.jpg',
  //       //       ),
  //       'website': websiteCtrl.text
  //     });
  //
  //     // var response = await dioClient.request(
  //     //   'https://xcvxcv.zxc/api/company/addNewCompany',
  //     //   options: dio.Options(
  //     //     method: 'POST',
  //     //   ),
  //     //   data: data,
  //     // );
  //
  //     print("FormData : $data");
  //     addNewCompanyState.value =
  //         ResponseClassify.completed(await addNewCompanyUseCase.call(data));
  //     print("AddNewCompany API Completed");
  //   } catch (e) {
  //     print("Error: $e");
  //     addNewCompanyState.value = ResponseClassify.error(e.toString());
  //   }
  // }

  Future<XFile?> compressImage(String path) async {
    final directory = await getTemporaryDirectory();
    final id = DateTime.now();
    final compressPath =
        "${directory.path}/compressedimage${id.toIso8601String()}.jpg";
    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      path,
      compressPath,
      quality: 40,
    );
    return compressedFile != null ? XFile(compressedFile.path) : null;
  }

  ///Method 2 Using body > json
  addNewCompany(CompanyDetailsModel company) async {
    addNewCompanyState.value = ResponseClassify.loading();
    try {
      final compressedImg = await compressImage(company.logo!.path);

      final file = File(compressedImg!.path);
      final imgBytes = await file.readAsBytes();
      logoBase64 = base64Encode(imgBytes);

      print("companyName : ${company.companyName}");
      print("companyEmail : ${company.companyEmailId}");
      print("companyWebsite : ${company.website}");
      log("companyLogo : ${logoBase64}");
      print("addNewCompany print Completed");
      addNewCompanyState.value = ResponseClassify.completed(
        await addNewCompanyUseCase.call(
          AddNewCompanyReqModel(
              companyName: company.companyName,
              companyEmail: company.companyEmailId,
              logo: logoBase64!,
              website: company.website!),
        ),
      );
      print("addNewCompany API Completed");
      addNewCompanyList.clear();
      addNewCompanyList.addAll(addNewCompanyState.value.data!.data);
      if (kDebugMode) {
        print("addNewCompanyList : $addNewCompanyList");
        print("addNewCompanyList Length : ${addNewCompanyList.length}");
      }
    } catch (e) {
      snackBarMsg("Failed", "$e", false);
      print("addNewCompanyList Error: ${e}");
      addNewCompanyState.value = ResponseClassify.error("$e");
    }
  }

  void addCompany(CompanyDetailsModel company) {
    companyList.add(company);
  }

  void removeCompany(int companyIndex) {
    companyList.removeAt(companyIndex);
  }

  void updateCompany(int companyIndex, CompanyDetailsModel company) {
    companyList[companyIndex] = company;
  }

  ///Employee
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final firmNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneNoCtrl = TextEditingController();

  final employeeList = <EmployeeDetailsModel>[
    EmployeeDetailsModel(
        empFirstName: "Arjun",
        empLastName: "Ashokan",
        companyName: "Arc Co",
        emailId: "arjun@gmail.com",
        phoneNo: "9876543210"),
  ].obs;

  void addEmployee(EmployeeDetailsModel employee) {
    employeeList.add(employee);
  }

  void removeEmployee(int employeeIndex) {
    employeeList.removeAt(employeeIndex);
  }

  void updateEmployee(int employeeIndex, EmployeeDetailsModel employee) {
    employeeList[employeeIndex] = employee;
  }

  ///IMAGE PICKER
  // File? selectedAndroidLogo;
  // Uint8List selectedWebLogo = Uint8List(8);
  // var companyLogo = Rxn<XFile>();

  // Future<void> pickImage() async {
  //   if (kIsWeb) {
  //     final ImagePicker _picker = ImagePicker();
  //     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //     if (image != null) {
  //       var webLogoFile = await image.readAsBytes();
  //       // setState(() {
  //         selectedWebLogo = webLogoFile;
  //         selectedAndroidLogo = File('a');
  //       // });
  //     } else {
  //       print("No Image selected");
  //     }
  //   } else if (!kIsWeb) {
  //     final ImagePicker _picker = ImagePicker();
  //     XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //     if (image != null) {
  //       var androidLogoFile = File(image.path);
  //       // setState(() {
  //         selectedAndroidLogo = androidLogoFile;
  //       // });
  //     } else {
  //       print("No Image selected");
  //     }
  //   } else {
  //     print("Other Issue in Logo Upload Function");
  //   }
  // }
}
