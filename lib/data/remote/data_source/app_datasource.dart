import 'package:flutter/foundation.dart';

import '../../../core/api_provider.dart';
import '../models/request/signUpReqModel.dart';
import '../models/response/signUpResModel.dart';
import '../remote_routes/app_remote_routes.dart';

abstract class AppDataSource {
  final ApiProvider apiProvider;

  AppDataSource(this.apiProvider);

  //SignUp
  Future<SignUpResModel> signUpDetails(SignUpReqModel reqModel);
}

class AppDataSourceImpl extends AppDataSource {
  AppDataSourceImpl(ApiProvider apiProvider) : super(apiProvider);

  //SignUp
  @override
  Future<SignUpResModel> signUpDetails(SignUpReqModel reqModel) async {
    final signUp = await apiProvider.post(AppRemoteRoutes.signUp, reqModel);
    var resSignUpDetails = SignUpResModel.fromJson(signUp);
    if (kDebugMode) {
      debugPrint("AppDataSource : resSignUpDetails \n$resSignUpDetails");
    }
    return resSignUpDetails;
  }
}
