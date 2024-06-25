import 'package:client/data/remote/models/request/addNewCompanyReqModel.dart';
import 'package:client/data/remote/models/request/signInReqModel.dart';
import 'package:client/data/remote/models/response/addNewCompanyResModel.dart';
import 'package:client/data/remote/models/response/getAllUsersResModel.dart';
import 'package:client/data/remote/models/response/signInResModel.dart';

import '../../data/remote/data_source/app_datasource.dart';
import '../../data/remote/models/request/signUpReqModel.dart';
import '../../data/remote/models/response/signUpResModel.dart';
import '../../data/repository/app_repository.dart';

class AppRepositoryImpl extends AppRepository {
  final AppDataSource appDataSource;

  AppRepositoryImpl(this.appDataSource);

  //signup
  @override
  Future<SignUpResModel> signUpDetails(SignUpReqModel reqModel) async {
    final signUpTest = await appDataSource.signUpDetails(reqModel);
    return signUpTest;
  }

  //signin
  @override
  Future<SignInResModel> signInDetails(SignInReqModel reqModel) async {
    final signInTest = await appDataSource.signInDetails(reqModel);
    return signInTest;
  }

  @override
  Future<GetAllUsersResModel> getAllUsersDetails() async {
    final getAllUsersTest = await appDataSource.getAllUsersDetails();
    return getAllUsersTest;
  }

  ///Method 1 Using body > FormData
  // @override
  // Future<AddNewCompanyResModel> addNewCompanyDetails(FormData formData) async {
  //   final addNewCompanyTest = await appDataSource.addNewCompanyDetails(formData);
  //   return addNewCompanyTest;
  // }
  ///Method 2 Using body > json
  @override
  Future<AddNewCompanyResModel> addNewCompanyDetails(
      AddNewCompanyReqModel reqModel) async {
    final addNewCompanyTest =
        await appDataSource.addNewCompanyDetails(reqModel);
    return addNewCompanyTest;
  }

  //signin
  // @override
  // Future<LoginResponseModal> loginDetails(LoginRequestModal modal) async {
  //   final loginTest = await appDataSource.loginDetails(modal);
  //   return loginTest;
  // }
}
