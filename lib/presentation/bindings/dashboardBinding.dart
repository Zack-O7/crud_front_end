import 'package:client/presentation/controllers/dashboardCtrl.dart';
import 'package:get/get.dart';

import '../../injector.dart';

class Dashboardbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardCtrl(sl(), sl()));
  }
}
