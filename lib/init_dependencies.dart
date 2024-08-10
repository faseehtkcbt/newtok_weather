import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:newtok_weather/features/admin/dashboard/data/datasource/user_list_datasource.dart';
import 'package:newtok_weather/features/admin/dashboard/presentation/bloc/user_list_bloc.dart';
import 'package:newtok_weather/features/admin/location_add_page/data/datasource/location_add_data_source.dart';
import 'package:newtok_weather/features/admin/location_add_page/data/repo_impl/location_add_repo_impl.dart';
import 'package:newtok_weather/features/admin/location_add_page/domain/repository/location_add_repository.dart';
import 'package:newtok_weather/features/admin/location_add_page/domain/usecase/location_add_usecase.dart';
import 'package:newtok_weather/features/admin/location_add_page/presentation/bloc/locationadd_bloc.dart';
import 'package:newtok_weather/features/user/dashboard/data/datasource/location_datasource.dart';
import 'package:newtok_weather/features/user/dashboard/data/repo_impl/location_repository_impl.dart';
import 'package:newtok_weather/features/user/dashboard/domain/repository/location_repository.dart';
import 'package:newtok_weather/features/user/dashboard/domain/usecase/get_location_usecase.dart';
import 'package:newtok_weather/features/user/dashboard/presentation/bloc/location_bloc.dart';
import 'package:newtok_weather/features/user/excel/data/datasource/excel_upload_datasource.dart';
import 'package:newtok_weather/features/user/excel/data/repo_impl/excel_upload_repository_impl.dart';
import 'package:newtok_weather/features/user/excel/domain/repository/excel_upload_repository.dart';
import 'package:newtok_weather/features/user/excel/domain/usecase/excel_upload_usecase.dart';
import 'package:newtok_weather/features/user/excel/presentation/bloc/excel_upload_bloc.dart';
import 'package:newtok_weather/features/user/excel/presentation/bloc/select_excel_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/internet/connection_checker.dart';
import 'features/admin/dashboard/data/repo_impl/user_list_repo_impl.dart';
import 'features/admin/dashboard/domain/repository/user_list_repository.dart';
import 'features/admin/dashboard/domain/usecase/get_users_usecase.dart';
import 'features/shared/auth/data/datasource/auth_datasource.dart';
import 'features/shared/auth/data/datasource/local_auth_datasource.dart';
import 'features/shared/auth/data/repository/auth_repo_impl.dart';
import 'features/shared/auth/domain/repository/auth_repository.dart';
import 'features/shared/auth/domain/usecase/login_usecase.dart';
import 'features/shared/auth/domain/usecase/register_usecase.dart';
import 'features/shared/auth/presentation/bloc/auth_bloc.dart';
import 'features/shared/splash/data/datasource/local_splash_datasource.dart';
import 'features/shared/splash/data/repo_impl/splash_repository_impl.dart';
import 'features/shared/splash/domain/repository/splash_repository.dart';
import 'features/shared/splash/domain/usecase/is_logged_in_usecase.dart';
import 'features/shared/splash/presentation/bloc/checkloggedin_bloc.dart';
import 'features/user/weather/data/datasource/weather_datasource.dart';
import 'features/user/weather/data/repo_impl/weather_repository_impl.dart';
import 'features/user/weather/domain/repository/weather_repository.dart';
import 'features/user/weather/domain/usecase/get_weather_usecase.dart';
import 'features/user/weather/presentation/bloc/weather_bloc.dart';
import 'firebase_options.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBody();
  final SharedPreferences pref = await SharedPreferences.getInstance();
  final firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
  serviceLocator
    ..registerLazySingleton<FirebaseAuth>(
        () => FirebaseAuth.instanceFor(app: firebaseApp))
    ..registerLazySingleton<FirebaseFirestore>(
        () => FirebaseFirestore.instanceFor(app: firebaseApp))
    ..registerLazySingleton<SharedPreferences>(() => pref);
}

void _initAuth() {
  serviceLocator
    ..registerFactory<InternetConnection>(() => InternetConnection())
    ..registerFactory<ConnectionChecker>(
        () => ConnectionCheckerImpl(serviceLocator<InternetConnection>()))
    ..registerFactory<AuthDataSource>(() => AuthDatasourceImpl(
        serviceLocator<FirebaseAuth>(),
        serviceLocator<FirebaseFirestore>(),
        serviceLocator<ConnectionChecker>()))
    ..registerFactory<LocalAuthDatasource>(
        () => LocalAuthDatasourceImpl(serviceLocator<SharedPreferences>()))
    ..registerFactory<AuthRepository>(() => AuthRepositoryImplementation(
        serviceLocator<AuthDataSource>(),
        serviceLocator<LocalAuthDatasource>()))
    ..registerFactory<RegisterUseCase>(
        () => RegisterUseCase(serviceLocator<AuthRepository>()))
    ..registerFactory<LoginUseCase>(
        () => LoginUseCase(serviceLocator<AuthRepository>()))
    ..registerLazySingleton<AuthBloc>(() => AuthBloc(
        registerUseCase: serviceLocator<RegisterUseCase>(),
        loginUseCase: serviceLocator<LoginUseCase>()))
    ..registerFactory<LocalSplashDatasource>(
        () => LocalSplashDatasourceImpl(serviceLocator<SharedPreferences>()))
    ..registerFactory<SplashRepository>(
        () => SplashRepositoryImpl(serviceLocator<LocalSplashDatasource>()))
    ..registerFactory<IsLoggedInUsecase>(
        () => IsLoggedInUsecase(serviceLocator<SplashRepository>()))
    ..registerLazySingleton<CheckloggedinBloc>(
        () => CheckloggedinBloc(serviceLocator<IsLoggedInUsecase>()));
}

void _initBody() {
  serviceLocator
    ..registerFactory<LocationAddDataSource>(() => LocationAddDatasourceImpl(
        internet: serviceLocator<ConnectionChecker>(),
        firestore: serviceLocator<FirebaseFirestore>()))
    ..registerFactory<LocationAddRepository>(() => LocationAddRepoImpl(
        dataSource: serviceLocator<LocationAddDataSource>()))
    ..registerFactory<LocationAddUsecase>(
        () => LocationAddUsecase(repo: serviceLocator<LocationAddRepository>()))
    ..registerLazySingleton<LocationAddBloc>(
        () => LocationAddBloc(serviceLocator<LocationAddUsecase>()))
    ..registerFactory<LocationDatasource>(() => LocationDatasourceImpl(
        internet: serviceLocator<ConnectionChecker>(),
        firestore: serviceLocator<FirebaseFirestore>()))
    ..registerFactory<LocationRepository>(() => LocationRepositoryImpl(
        datasource: serviceLocator<LocationDatasource>()))
    ..registerFactory<GetLocationUsecase>(() =>
        GetLocationUsecase(repository: serviceLocator<LocationRepository>()))
    ..registerLazySingleton<LocationBloc>(
        () => LocationBloc(serviceLocator<GetLocationUsecase>()))
    ..registerFactory<UserListDatasource>(() => UserListDatasourceImpl(
        internet: serviceLocator<ConnectionChecker>(),
        firestore: serviceLocator<FirebaseFirestore>()))
    ..registerFactory<UserListRepository>(() => UserListRepositoryImpl(
        datasource: serviceLocator<UserListDatasource>()))
    ..registerFactory<GetUsersUsecase>(
        () => GetUsersUsecase(repository: serviceLocator<UserListRepository>()))
    ..registerLazySingleton<UserListBloc>(
        () => UserListBloc(serviceLocator<GetUsersUsecase>()))
    ..registerFactory<WeatherDatasource>(() => WeatherDatasourceImpl(
          connectionChecker: serviceLocator<ConnectionChecker>(),
        ))
    ..registerFactory<WeatherRepository>(() =>
        WeatherRepositoryImpl(datasource: serviceLocator<WeatherDatasource>()))
    ..registerFactory<GetWeatherUsecase>(
        () => GetWeatherUsecase(repo: serviceLocator<WeatherRepository>()))
    ..registerLazySingleton<WeatherBloc>(
        () => WeatherBloc(serviceLocator<GetWeatherUsecase>()))
    ..registerLazySingleton<SelectExcelCubit>(() => SelectExcelCubit())
    ..registerFactory<ExcelUploadDataSource>(() => ExcelUploadDatasourceImpl(
        internet: serviceLocator<ConnectionChecker>(),
        firestore: serviceLocator<FirebaseFirestore>()))
    ..registerFactory<ExcelUploadRepository>(() => ExcelUploadRepoImpl(
        dataSource: serviceLocator<ExcelUploadDataSource>()))
    ..registerFactory<ExcelUploadUsecase>(
        () => ExcelUploadUsecase(repo: serviceLocator<ExcelUploadRepository>()))
    ..registerLazySingleton<ExcelUploadBloc>(
        () => ExcelUploadBloc(serviceLocator<ExcelUploadUsecase>()));
}
