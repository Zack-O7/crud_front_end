import 'package:client/presentation/controllers/dashboardCtrl.dart';
import 'package:get/get.dart';

class Dashboardbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardCtrl());
  }
}
