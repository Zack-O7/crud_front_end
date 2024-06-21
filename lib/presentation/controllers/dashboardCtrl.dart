import 'package:client/core/response_classify.dart';
import 'package:client/core/usecase.dart';
import 'package:client/data/remote/models/response/getAllUsersResModel.dart';
import 'package:client/domain/entities/userDetailsModel.dart';
import 'package:client/domain/usecases/getAllUsersUseCase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/companyDetailsModel.dart';
import '../../domain/entities/employeeDetailsModel.dart';
import '../widgets/snackBarMsg.dart';

class DashboardCtrl extends GetxController {
  final GetAllUsersUseCase getAllUsersUseCase;

  DashboardCtrl(this.getAllUsersUseCase);

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
}
