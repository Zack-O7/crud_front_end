import 'package:client/data/remote/models/request/addNewCompanyReqModel.dart';
import 'package:client/data/remote/models/request/signInReqModel.dart';
import 'package:flutter/foundation.dart';

import '../../../core/api_provider.dart';
import '../models/request/signUpReqModel.dart';
import '../models/response/addNewCompanyResModel.dart';
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

  //AddNewCompany'
  ///Method 1 Using body > FormData
  // Future<AddNewCompanyResModel> addNewCompanyDetails(FormData formData);

  ///Method 2 Using body > json
  Future<AddNewCompanyResModel> addNewCompanyDetails(
      AddNewCompanyReqModel reqModel);
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
      debugPrint(
          "AppDataSource : resGetAllUsersDetails \n$resGetAllUsersDetails");
    }
    return resGetAllUsersDetails;
  }

  ///Method 1 Using body > FormData
  //  @override
  //  Future<AddNewCompanyResModel> addNewCompanyDetails(FormData formData) async {
  // // Convert FormData to Map<String, dynamic>
  //    Map<String, dynamic> body = {};
  //    formData.fields.forEach((field) {
  //      body[field.key] = field.value;
  //    });
  //
  //    // Handle file fields separately if needed
  //    formData.files.forEach((file) {
  //      body[file.key] = file.value;
  //    });
  //
  //
  //    final addNewCompany =
  //        await apiProvider.request(AppRemoteRoutes.addNewCompany, body, 'POST');
  //    var resAddNewCompanyDetails = AddNewCompanyResModel.fromJson(addNewCompany);
  //    if (kDebugMode) {
  //      debugPrint(
  //          "AppDataSource : resAddNewCompanyDetails \n$resAddNewCompanyDetails");
  //    }
  //    return resAddNewCompanyDetails;
  //  }

  ///Method 2 Using body > json
  @override
  Future<AddNewCompanyResModel> addNewCompanyDetails(
      AddNewCompanyReqModel reqModel) async {
    final addNewCompany =
        await apiProvider.post(AppRemoteRoutes.addNewCompany, reqModel);
    var resAddNewCompanyDetails = AddNewCompanyResModel.fromJson(addNewCompany);
    if (kDebugMode) {
      debugPrint(
          "AppDataSource : resAddNewCompanyDetails \n$resAddNewCompanyDetails");
    }
    return resAddNewCompanyDetails;
  }
}
