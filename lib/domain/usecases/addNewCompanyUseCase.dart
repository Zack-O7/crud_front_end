import 'package:client/core/usecase.dart';
import 'package:client/data/remote/models/request/addNewCompanyReqModel.dart';
import 'package:client/data/remote/models/response/addNewCompanyResModel.dart';
import 'package:client/data/repository/app_repository.dart';

///Method 1 Using body > FormData
// class AddNewCompanyUseCase extends UseCase<AddNewCompanyResModel, FormData>{
// final AppRepository appRepository;
//
//   AddNewCompanyUseCase(this.appRepository);
//
//   @override
//   Future<AddNewCompanyResModel> call(FormData params) async {
//     final addNewCompanyTest = await appRepository.addNewCompanyDetails(params);
//     print("AddNewCompanyTest $addNewCompanyTest");
//     return addNewCompanyTest;
//   }
// }

///Method 2 Using body > json
class AddNewCompanyUseCase
    extends UseCase<AddNewCompanyResModel, AddNewCompanyReqModel> {
  final AppRepository appRepository;

  AddNewCompanyUseCase(this.appRepository);

  @override
  Future<AddNewCompanyResModel> call(AddNewCompanyReqModel params) async {
    final addNewCompanyTest = await appRepository.addNewCompanyDetails(params);
    print("AddNewCompanyTest $addNewCompanyTest");
    return addNewCompanyTest;
  }
}
