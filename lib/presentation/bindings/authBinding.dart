import 'package:client/injector.dart';
import 'package:client/presentation/controllers/authCtrl.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthCtrl(sl(),sl()));
  }
}
