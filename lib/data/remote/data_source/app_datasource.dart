import 'package:client/data/remote/models/request/signInReqModel.dart';
import 'package:flutter/foundation.dart';

import '../../../core/api_provider.dart';
import '../models/request/signUpReqModel.dart';
import '../models/response/getAllUsersResModel.dart';
import '../models/response/signInResModel.dart';
import '../models/response/signUpResModel.dart';
import '../remote_routes/app_remote_routes.dart';

abstract class AppDataSource {
  final ApiProvider apiProvider;

  AppDataSource(this.apiProvider);

  //SignUp
  Future<SignUpResModel> signUpDetails(SignUpReqModel reqModel);

  //SignIn
  Future<SignInResModel> signInDetails(SignInReqModel reqModel);

  //GetAllUsers
  Future<GetAllUsersResModel> getAllUsersDetails();
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

  @override
  Future<SignInResModel> signInDetails(SignInReqModel reqModel) async {
    final signIn = await apiProvider.post(AppRemoteRoutes.signIn, reqModel);
    var resSignInDetails = SignInResModel.fromJson(signIn);
    if (kDebugMode) {
      debugPrint("AppDataSource : resSignInDetails \n$resSignInDetails");
    }
    return resSignInDetails;
  }

  @override
  Future<GetAllUsersResModel> getAllUsersDetails() async {
    final getAllUsers = await apiProvider.get(AppRemoteRoutes.getAllUsers);
    var resGetAllUsersDetails = GetAllUsersResModel.fromJson(getAllUsers);
    if (kDebugMode) {
      debugPrint("AppDataSource : resGetAllUsersDetails \n$resGetAllUsersDetails");
    }
    return resGetAllUsersDetails;
  }
}
