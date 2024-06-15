import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/dashboardCtrl.dart';

class UserTable extends StatelessWidget {
  UserTable({super.key});

  final dashboardCtrl = Get.find<DashboardCtrl>();

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(
          label: Text("First Name"),
        ),
        DataColumn(
          label: Text("Last Name"),
        ),
        DataColumn(
          label: Text("EMail ID"),
        ),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text("FName")),
          DataCell(Text("LName")),
          DataCell(Text("Email")),
        ]),
      ],
    );
  }
}
