import 'package:client/core/usecase.dart';
import 'package:client/data/remote/models/request/signInReqModel.dart';
import 'package:client/data/remote/models/response/signInResModel.dart';
import 'package:client/data/repository/app_repository.dart';

class SignInUseCase extends UseCase<SignInResModel, SignInReqModel> {
  final AppRepository appRepository;

  SignInUseCase(this.appRepository);

  @override
  Future<SignInResModel> call(SignInReqModel params) async {
    final signInTest = await appRepository.signInDetails(params);
    print("SignInTest $signInTest");
    return signInTest;
  }
}
