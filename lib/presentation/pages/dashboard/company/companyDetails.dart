import 'dart:io';

import 'package:client/domain/entities/companyDetailsModel.dart';
import 'package:client/presentation/pages/dashboard/company/createNewCompany.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../domain/entities/employeeDetailsModel.dart';
import '../../../controllers/dashboardCtrl.dart';
import '../../../themes/app_colors.dart';

class CompanyDetails extends StatefulWidget {
  CompanyDetails({super.key});

  @override
  State<CompanyDetails> createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {
  final dashboardCtrl = Get.find<DashboardCtrl>();

  // dynamic selectedImage;
  var selectedImage = Rxn<XFile>();
  var companyLogo = Rxn<XFile>();

  @override
  Widget build(BuildContext context) {
    // return DataTable(
    //   // decoration: BoxDecoration(boxShadow: ),
    //   showCheckboxColumn: false,
    //       // columnSpacing: w * 0.099,
    //       border: TableBorder.all(color: Theme.of(context).primaryColor),
    //       headingRowColor: WidgetStateColor.resolveWith(
    //           (states) => Theme.of(context).primaryColorDark),
    //       headingTextStyle: const TextStyle(
    //           color: AppColors.white, fontWeight: FontWeight.w600),
    //   columns: [
    //     DataColumn(
    //       label: Text("First Name"),
    //     ),
    //     DataColumn(
    //       label: Text("Last Name"),
    //     ),
    //     DataColumn(
    //       label: Text("Company"),
    //     ),
    //     DataColumn(
    //       label: Text("E-Mail ID"),
    //     ),
    //     DataColumn(
    //       label: Text("Phone No"),
    //     ),
    //     DataColumn(
    //       label: Text("Action"),
    //     ),
    //   ],
    //   rows:
    //   dashboardCtrl.userList.map((e) =>
    //     DataRow(cells: [
    //       DataCell(Text(e.fName)),
    //       DataCell(Text(e.lName)),
    //       DataCell(Text(e.email)),
    //     ]),
    // ).toList());

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "COMPANY DETAILS",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    // _createCompDialog();
                    Get.to(CreateNewCompany());
                  },
                  child: Row(
                    children: [
                      Text(
                        "Create",
                        style: TextStyle(color: Colors.blue),
                      ),
                      Icon(
                        Icons.add_circle_outlined,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                    child: Text("Company Name",
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("E-Mail ID",
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Logo",
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Website",
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Action",
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: dashboardCtrl.companyList.length,
                itemBuilder: (context, index) {
                  final company = dashboardCtrl.companyList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(child: Text(company.companyName)),
                        Expanded(child: Text(company.companyEmailId)),
                        // Expanded(child: Text(company.logo)),
                        Expanded(child: Text(company.website!)),
                        Expanded(
                          child: width <= 500
                              ? Column(
                                  children: [
                                    // IconButton(
                                    //   icon: Icon(
                                    //       Icons.chrome_reader_mode_outlined,
                                    //       color: Colors.green),
                                    //   onPressed: () {},
                                    // ),
                                    IconButton(
                                      icon:
                                          Icon(Icons.edit, color: Colors.blue),
                                      onPressed: () {
                                        // _updateEmployeeDialog(
                                        //     context, index, employee);
                                      },
                                    ),
                                    IconButton(
                                      icon:
                                          Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        // dashboardCtrl.removeEmployee(index);
                                      },
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    IconButton(
                                      icon:
                                          Icon(Icons.edit, color: Colors.blue),
                                      onPressed: () {
                                        // _updateEmployeeDialog(
                                        //     context, index, employee);
                                      },
                                    ),
                                    IconButton(
                                      icon:
                                          Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        // dashboardCtrl.removeEmployee(index);
                                      },
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // void _createCompDialog() {
  //   Get.defaultDialog(
  //     title: "Add New Company",
  //     content: Padding(
  //       padding: const EdgeInsets.all(10.0),
  //       child: Column(
  //         children: [
  //           TextFormField(
  //             controller: dashboardCtrl.companyNameCtrl,
  //             decoration: InputDecoration(labelText: "Company Name"),
  //           ),
  //           TextFormField(
  //             controller: dashboardCtrl.companyEmailCtrl,
  //             decoration: InputDecoration(labelText: "Company E-Mail ID"),
  //           ),
  //           // Row(
  //           //   children: [
  //           //     Text("Logo"),
  //           //     ElevatedButton(
  //           //       onPressed: () async {
  //           //         selectedImage = await pickImage();
  //           //       },
  //           //       child: Text("Upload Image"),
  //           //     ),
  //           //   ],
  //           // ),
  //           Row(
  //             children: [
  //               ElevatedButton(
  //                 onPressed: () async {
  //                   selectedImage = await pickImage();
  //                 },
  //                 child: Text('Pick Logo'),
  //               ),
  //               // if (selectedImage != null)
  //               Obx(
  //                 () => selectedImage.value != null
  //                     ? Container(
  //                         width: 50,
  //                         height: 50,
  //                         child: Image.file(File(selectedImage.value!.path),
  //                             fit: BoxFit.cover),
  //                         // child: selectedImage is Uint8List
  //                         //     ? Image.memory(selectedImage, fit: BoxFit.cover)
  //                         //     : Image.file(selectedImage, fit: BoxFit.cover),
  //                       )
  //                     : Icon(Icons.error),
  //               ),
  //             ],
  //           ),

  //           TextFormField(
  //             controller: dashboardCtrl.websiteCtrl,
  //             decoration: InputDecoration(labelText: "Website"),
  //           ),
  //         ],
  //       ),
  //     ),
  //     confirm: ElevatedButton(
  //       style: ElevatedButton.styleFrom(
  //           backgroundColor: Colors.blue, foregroundColor: Colors.white),
  //       onPressed: () {
  //         final newCompany = CompanyDetailsModel(
  //           companyName: dashboardCtrl.companyNameCtrl.text,
  //           companyEmailId: dashboardCtrl.companyEmailCtrl.text,
  //           logo: selectedImage != null
  //               ? Image.file(File(selectedImage.value!.path))
  //               : null,
  //           website: dashboardCtrl.websiteCtrl.text,
  //         );
  //         // dashboardCtrl.addEmployee(newEmployee);
  //         Get.back();
  //         dashboardCtrl.companyNameCtrl.clear();
  //         dashboardCtrl.companyEmailCtrl.clear();
  //         dashboardCtrl.websiteCtrl.clear();
  //       },
  //       child: Text("Create"),
  //     ),
  //     cancel: ElevatedButton(
  //       style: ElevatedButton.styleFrom(
  //           backgroundColor: Colors.red, foregroundColor: Colors.white),
  //       onPressed: () {
  //         Get.back();
  //       },
  //       child: Text("Cancel"),
  //     ),
  //   );
  // }

  void _updateEmployeeDialog(
      BuildContext context, int index, EmployeeDetailsModel employee) {
    final firstNameCtrl = TextEditingController(text: employee.empFirstName);
    final lastNameCtrl = TextEditingController(text: employee.empLastName);
    final companyNameCtrl = TextEditingController(text: employee.companyName);
    final emailCtrl = TextEditingController(text: employee.emailId);
    final phoneNoCtrl = TextEditingController(text: employee.phoneNo);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Employee'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: firstNameCtrl,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: lastNameCtrl,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              TextField(
                controller: companyNameCtrl,
                decoration: InputDecoration(labelText: 'Company Name'),
              ),
              TextField(
                controller: emailCtrl,
                decoration: InputDecoration(labelText: 'E-Mail ID'),
              ),
              TextField(
                controller: phoneNoCtrl,
                decoration: InputDecoration(labelText: 'Phone No'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final updatedEmployee = EmployeeDetailsModel(
                  empFirstName: firstNameCtrl.text,
                  empLastName: lastNameCtrl.text,
                  companyName: companyNameCtrl.text,
                  emailId: emailCtrl.text,
                  phoneNo: phoneNoCtrl.text,
                );
                dashboardCtrl.updateEmployee(index, updatedEmployee);
                Get.back();
                firstNameCtrl.clear();
                lastNameCtrl.clear();
                companyNameCtrl.clear();
                emailCtrl.clear();
                phoneNoCtrl.clear();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
