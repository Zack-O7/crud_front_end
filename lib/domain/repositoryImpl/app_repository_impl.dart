import '../../data/remote/data_source/app_datasource.dart';
import '../../data/remote/models/request/signUpReqModel.dart';
import '../../data/remote/models/response/signUpResModel.dart';
import '../../data/repository/app_respository.dart';

class AppRepositoryImpl extends AppRepository {
  final AppDataSource appDataSource;

  AppRepositoryImpl(this.appDataSource);

  //signup
  @override
  Future<SignUpResModel> signUpDetails(SignUpReqModel model) async {
    final signUpTest = await appDataSource.signUpDetails(model);
    return signUpTest;
  }

  //signin
  // @override
  // Future<LoginResponseModal> loginDetails(LoginRequestModal modal) async {
  //   final loginTest = await appDataSource.loginDetails(modal);
  //   return loginTest;
  // }
}
