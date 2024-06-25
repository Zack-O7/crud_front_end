import 'package:client/presentation/pages/dashboard/company/createNewCompany.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/dashboardCtrl.dart';
import 'updateCompanyDetails.dart';

class CompanyDetails extends StatefulWidget {
  CompanyDetails({super.key});

  @override
  State<CompanyDetails> createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {
  final dashboardCtrl = Get.find<DashboardCtrl>();

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
                  "COMPANY DETAILS",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    // _createCompDialog();
                    Get.to(() => CreateNewCompany());
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
                    child: Text("Company",
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
                        // Expanded(
                        //     child: Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Image.memory(
                        //     company.logo!,
                        //     height: height * 0.07,
                        //   ),
                        // )),
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
                                        // _updateCompanyDialog(
                                        //     context, index, company);
                                        Get.to(
                                          () => UpdateCompanyDetails(
                                            index: index,
                                            company: company,
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon:
                                          Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        dashboardCtrl.removeCompany(index);
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
                                        // _updateCompanyDialog(
                                        //     context, index, company);
                                        Get.to(
                                          () => UpdateCompanyDetails(
                                            index: index,
                                            company: company,
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon:
                                          Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        dashboardCtrl.removeCompany(index);
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
}
