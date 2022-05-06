import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/app/app_prefernces.dart';
import 'package:test_app/data/data_source/remote_data_source.dart';
import 'package:test_app/data/network/app_api.dart';
import 'package:test_app/data/network/dio_factory.dart';
import 'package:test_app/data/network/network_info.dart';
import 'package:test_app/data/repository/repository_impl.dart';
import 'package:test_app/domain/repository/repository.dart';
import 'package:test_app/domain/usecase/login_usecase.dart';
import 'package:test_app/presentation/login/login_viewmodel.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final SharedPreferences spInst = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => spInst);

  instance
      .registerLazySingleton<AppPrefernces>(() => AppPrefernces(instance()));

  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(DataConnectionChecker()));

  // dioFactory

  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  final dio = await instance<DioFactory>().getDio();
  instance
      .registerLazySingleton<AppServicesClient>(() => AppServicesClient(dio));
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplementer(instance()));

  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}
