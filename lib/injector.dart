import 'package:client/domain/usecases/addNewCompanyUseCase.dart';
import 'package:client/domain/usecases/getAllUsersUseCase.dart';
import 'package:get_it/get_it.dart';

import 'core/api_provider.dart';
import 'data/remote/data_source/app_datasource.dart';
import 'data/repository/app_repository.dart';
import 'domain/repositoryImpl/app_repository_impl.dart';
import 'domain/usecases/signInUseCase.dart';
import 'domain/usecases/signUpUseCase.dart';

final GetIt sl = GetIt.instance;

Future<void> setUp() async {
  sl.registerSingleton<ApiProvider>(ApiProvider());
  sl.registerLazySingleton<AppDataSource>(() => AppDataSourceImpl(sl()));
  sl.registerLazySingleton<AppRepository>(() => AppRepositoryImpl(sl()));
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(sl()));
  sl.registerLazySingleton<SignInUseCase>(() => SignInUseCase(sl()));
  sl.registerLazySingleton<GetAllUsersUseCase>(() => GetAllUsersUseCase(sl()));
  sl.registerLazySingleton<AddNewCompanyUseCase>(
      () => AddNewCompanyUseCase(sl()));
}
