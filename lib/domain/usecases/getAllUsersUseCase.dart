import 'package:client/core/usecase.dart';
import 'package:client/data/remote/models/response/getAllUsersResModel.dart';
import 'package:client/data/repository/app_repository.dart';

class GetAllUsersUseCase extends UseCase<GetAllUsersResModel, NoParams> {
  final AppRepository appRepository;
  GetAllUsersUseCase(this.appRepository);

  @override
  Future<GetAllUsersResModel> call(NoParams params) async {
    var test = await appRepository.getAllUsersDetails();
    print("GetAllUsersUseCase $test");
    return test;
  }
}
