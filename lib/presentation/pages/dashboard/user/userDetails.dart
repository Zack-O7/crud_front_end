import 'package:client/core/response_classify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/dashboardCtrl.dart';
import '../../../themes/app_colors.dart';

class UserDetails extends StatefulWidget {
  UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final dashboardCtrl = Get.find<DashboardCtrl>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(
                children: [
                  Text(
                    "USER DETAILS",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Obx(
                    () => dashboardCtrl.getAllUsersState.value.status ==
                            Status.LOADING
                        ? Center(
                            child: Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: CircularProgressIndicator(),
                          ))
                        : Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: height * 0.05),
                            child: DataTable(
                                showCheckboxColumn: false,
                                columnSpacing: width * 0.099,
                                border: TableBorder.symmetric(
                                    borderRadius: BorderRadius.circular(20),
                                    outside: BorderSide(
                                        color: Theme.of(context).primaryColor)),
                                headingRowColor: WidgetStateColor.resolveWith(
                                    (states) =>
                                        Theme.of(context).primaryColorDark),
                                headingTextStyle: const TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600),
                                columns: [
                                  DataColumn(
                                    label: Text("First Name"),
                                  ),
                                  DataColumn(
                                    label: Text("Last Name"),
                                  ),
                                  DataColumn(
                                    label: Text("E-Mail ID"),
                                  ),
                                ],
                                // rows: dashboardCtrl.userList
                                rows: dashboardCtrl.getAllUsersList
                                    .map(
                                      (e) => DataRow(cells: [
                                        DataCell(Text(e.firstName)),
                                        DataCell(Text(e.lastName)),
                                        DataCell(Text(e.email)),
                                      ]),
                                    )
                                    .toList()),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
