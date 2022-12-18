import 'package:connectivity/connectivity.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_tech/Core/Network/networkInfo.dart';
import 'package:test_tech/Features/Home/Data/Datasource/Implementations/homeRemoteDatasourceImpl.dart';
import 'package:test_tech/Features/Home/Data/Datasource/homeRemoteDatasource.dart';
import 'package:test_tech/Features/Home/Data/Repositories/homeRepositoryImpl.dart';
import 'package:test_tech/Features/Home/Domain/Repositories/homeRepository.dart';
import 'package:test_tech/Features/Home/Domain/Usecases/getData.dart';
import 'package:test_tech/Features/Home/Presentation/bloc/home_bloc.dart';

GetIt sl = GetIt.instance;

void init() {
//* ---------------------------------  Feature Home  --------------------------

  // ? Bloc
  sl.registerFactory(() => HomeBloc(getData: sl()));

  // ? Use cases
  sl.registerLazySingleton(() => GetData(sl()));

  // sl.registerLazySingleton(() => Register(sl()));

  // ? Repository
  sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  // ? Data sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(client: sl()));

  //*--------------------------------------- External  --------------------------------------

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => SharedPreferences.getInstance());
}
