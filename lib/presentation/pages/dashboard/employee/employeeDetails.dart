import 'package:client/domain/entities/employeeDetailsModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/dashboardCtrl.dart';

class EmployeeDetails extends StatelessWidget {
  EmployeeDetails({super.key});

  final dashboardCtrl = Get.find<DashboardCtrl>();

  // final firstNameCtrl = TextEditingController();
  // final lastNameCtrl = TextEditingController();
  // final companyNameCtrl = TextEditingController();
  // final emailCtrl = TextEditingController();
  // final phoneNoCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  "EMPLOYEE DETAILS",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    _createEmpDialog();
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
                    child: Text("First Name",
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Last Name",
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Company",
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("E-Mail ID",
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Phone No",
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
                itemCount: dashboardCtrl.employeeList.length,
                itemBuilder: (context, index) {
                  final employee = dashboardCtrl.employeeList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(child: Text(employee.empFirstName)),
                        Expanded(child: Text(employee.empLastName)),
                        Expanded(child: Text(employee.companyName)),
                        Expanded(child: Text(employee.emailId)),
                        Expanded(child: Text(employee.phoneNo)),
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
                                        _updateEmployeeDialog(
                                            context, index, employee);
                                      },
                                    ),
                                    IconButton(
                                      icon:
                                          Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        dashboardCtrl.removeEmployee(index);
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
                                        _updateEmployeeDialog(
                                            context, index, employee);
                                      },
                                    ),
                                    IconButton(
                                      icon:
                                          Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        dashboardCtrl.removeEmployee(index);
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

  void _createEmpDialog() {
    Get.defaultDialog(
      title: "Add New Employee",
      content: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: dashboardCtrl.firstNameCtrl,
              decoration: InputDecoration(labelText: "First Name"),
            ),
            TextFormField(
              controller: dashboardCtrl.lastNameCtrl,
              decoration: InputDecoration(labelText: "Last Name"),
            ),
            TextFormField(
              controller: dashboardCtrl.emailCtrl,
              decoration: InputDecoration(labelText: "E-Mail ID"),
            ),
            TextFormField(
              controller: dashboardCtrl.phoneNoCtrl,
              decoration: InputDecoration(labelText: "Phone No"),
            ),
          ],
        ),
      ),
      confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, foregroundColor: Colors.white),
        onPressed: () {
          final newEmployee = EmployeeDetailsModel(
              empFirstName: dashboardCtrl.firstNameCtrl.text,
              empLastName: dashboardCtrl.lastNameCtrl.text,
              companyName: dashboardCtrl.firmNameCtrl.text,
              emailId: dashboardCtrl.emailCtrl.text,
              phoneNo: dashboardCtrl.phoneNoCtrl.text);
          dashboardCtrl.addEmployee(newEmployee);
          Get.back();
          dashboardCtrl.firstNameCtrl.clear();
          dashboardCtrl.lastNameCtrl.clear();
          dashboardCtrl.firmNameCtrl.clear();
          dashboardCtrl.emailCtrl.clear();
          dashboardCtrl.phoneNoCtrl.clear();
        },
        child: Text("Create"),
      ),
      cancel: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, foregroundColor: Colors.white),
        onPressed: () {
          Get.back();
        },
        child: Text("Cancel"),
      ),
    );
  }

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
          title: Text(
            "UPDATE EMPLOYEE DETAILS",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, foregroundColor: Colors.white),
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, foregroundColor: Colors.white),
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
