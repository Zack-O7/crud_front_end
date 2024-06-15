import '../remote/models/request/signUpReqModel.dart';
import '../remote/models/response/signUpResModel.dart';

abstract class AppRepository {
  //signup
  Future<SignUpResModel> signUpDetails(SignUpReqModel reqModel);
}
