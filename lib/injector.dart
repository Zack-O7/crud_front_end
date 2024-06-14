import 'package:get_it/get_it.dart';

import 'core/api_provider.dart';
import 'data/remote/data_source/app_datasource.dart';
import 'data/repository/app_respository.dart';
import 'domain/repositoryImpl/app_repository_impl.dart';
import 'domain/usecases/signUpUseCase.dart';

final GetIt sl = GetIt.instance;

Future<void> setUp() async {
  sl.registerSingleton<ApiProvider>(ApiProvider());
  sl.registerLazySingleton<AppDataSource>(() => AppDataSourceImpl(sl()));
  sl.registerLazySingleton<AppRepository>(() => AppRepositoryImpl(sl()));
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase(sl()));
}
