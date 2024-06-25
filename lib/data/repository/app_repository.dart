import 'package:client/data/remote/models/request/addNewCompanyReqModel.dart';

import '../remote/models/request/signInReqModel.dart';
import '../remote/models/request/signUpReqModel.dart';
import '../remote/models/response/addNewCompanyResModel.dart';
import '../remote/models/response/getAllUsersResModel.dart';
import '../remote/models/response/signInResModel.dart';
import '../remote/models/response/signUpResModel.dart';

abstract class AppRepository {
  //signup
  Future<SignUpResModel> signUpDetails(SignUpReqModel reqModel);
  //SignIn
  Future<SignInResModel> signInDetails(SignInReqModel reqModel);
  //GetAllUsers
  Future<GetAllUsersResModel> getAllUsersDetails();
  //AddNewCompany
  ///Method 1 Using body > FormData
  // Future<AddNewCompanyResModel> addNewCompanyDetails(FormData formData);
  ///Method 2 Using body > json
  Future<AddNewCompanyResModel> addNewCompanyDetails(
      AddNewCompanyReqModel reqModel);
}
