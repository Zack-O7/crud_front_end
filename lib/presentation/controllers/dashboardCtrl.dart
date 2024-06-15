import 'package:client/domain/entities/userDetailsModel.dart';
import 'package:get/get.dart';

class DashboardCtrl extends GetxController {
  final userList = <UserDetailsModel>[
    UserDetailsModel("Adam", "John", "adam@gmail.com"),
    UserDetailsModel("John", "Cena", "cena@gmail.com"),
    UserDetailsModel("Brock", "Lesner", "brock@gmail.com"),
  ].obs;

  userDetails() {}
}
