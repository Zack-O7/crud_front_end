import 'package:client/presentation/controllers/dashboardCtrl.dart';
import 'package:client/presentation/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'company/companyDetails.dart';
import 'employee/employeeDetails.dart';
import 'user/userDetails.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final dashboardCtrl = Get.find<DashboardCtrl>();

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    UserDetails(),
    CompanyDetails(),
    EmployeeDetails(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    dashboardCtrl.getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ADMIN",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        actions: [
          TextButton(
            onPressed: () {
              _onItemTapped(0);
              dashboardCtrl.getAllUsers();
            },
            child: Text(
              "USERS",
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              _onItemTapped(1);
            },
            child: Text(
              "COMPANIES",
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              _onItemTapped(2);
            },
            child: Text(
              "EMPLOYEES",
              style: TextStyle(color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.offAllNamed(AppPages.signIn);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
    );
  }
}
