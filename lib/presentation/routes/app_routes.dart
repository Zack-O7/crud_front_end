import 'package:client/presentation/bindings/authBinding.dart';
import 'package:client/presentation/pages/signIn.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../pages/dashboard/dashboard.dart';
import '../pages/signUp.dart';
import 'app_pages.dart';

class AppRoutes {
  static List<GetPage> routes = [
    GetPage(
        name: AppPages.signIn, page: () => SignIn(), binding: AuthBinding()),
    GetPage(
        name: AppPages.signUp, page: () => SignUp(), binding: AuthBinding()),
    GetPage(
      name: AppPages.dashboard,
      page: () => Dashboard(),
    ),
    // GetPage(name: AppPages.searchBar, page: () => SearchBarBG(),),
  ];
}
