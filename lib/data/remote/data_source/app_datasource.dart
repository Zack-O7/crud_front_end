import 'package:flutter/foundation.dart';

import '../../../core/api_provider.dart';
import '../models/request/signUpReqModel.dart';
import '../models/response/signUpResModel.dart';
import '../remote_routes/app_remote_routes.dart';

abstract class AppDataSource {
  final ApiProvider apiProvider;

  AppDataSource(this.apiProvider);

  Future<SignUpResModel> signUpDetails(SignUpReqModel model);
}

class AppDataSourceImpl extends AppDataSource {
  AppDataSourceImpl(ApiProvider apiProvider) : super(apiProvider);

  @override
  Future<SignUpResModel> signUpDetails(SignUpReqModel model) async {
    final signUp = await apiProvider.post(AppRemoteRoutes.signUp, model);
    var resSignUpDetails = SignUpResModel.fromJson(signUp);
    if (kDebugMode) {
      debugPrint("AppDataSource : resSignUpDetails \n$resSignUpDetails");
    }
    return resSignUpDetails;
  }
}
