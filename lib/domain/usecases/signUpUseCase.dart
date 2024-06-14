import 'package:client/core/usecase.dart';
import 'package:client/data/repository/app_respository.dart';

import '../../data/remote/models/request/signUpReqModel.dart';
import '../../data/remote/models/response/signUpResModel.dart';

class SignUpUseCase extends UseCase<SignUpResModel, SignUpReqModel> {
  final AppRepository appRepository;

  SignUpUseCase(this.appRepository);

  @override
  Future<SignUpResModel> call(SignUpReqModel params) async {
    final signUpTest = await appRepository.signUpDetails(params);
    print("SignUpUseCase $signUpTest");
    return signUpTest;
  }
}
