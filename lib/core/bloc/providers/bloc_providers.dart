import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newtok_weather/features/admin/location_add_page/presentation/bloc/locationadd_bloc.dart';
import 'package:newtok_weather/features/user/excel/presentation/bloc/excel_upload_bloc.dart';
import 'package:newtok_weather/features/user/excel/presentation/bloc/select_excel_cubit.dart';
import '../../../features/admin/dashboard/presentation/bloc/user_list_bloc.dart';
import '../../../features/shared/auth/presentation/bloc/auth_bloc.dart';
import '../../../features/shared/splash/presentation/bloc/checkloggedin_bloc.dart';
import '../../../features/user/dashboard/presentation/bloc/location_bloc.dart';
import '../../../features/user/weather/presentation/bloc/weather_bloc.dart';
import '../../../init_dependencies.dart';

class BlocProviders {
  BlocProviders._();
  static final dynamic providers = [
    BlocProvider<AuthBloc>(create: (context) => serviceLocator<AuthBloc>()),
    BlocProvider<LocationAddBloc>(
        create: (context) => serviceLocator<LocationAddBloc>()),
    BlocProvider<LocationBloc>(
        create: (context) => serviceLocator<LocationBloc>()),
    BlocProvider<CheckloggedinBloc>(
        create: (context) => serviceLocator<CheckloggedinBloc>()),
    BlocProvider<UserListBloc>(
        create: (context) => serviceLocator<UserListBloc>()),
    BlocProvider<WeatherBloc>(
        create: (context) => serviceLocator<WeatherBloc>()),
    BlocProvider<SelectExcelCubit>(
        create: (context) => serviceLocator<SelectExcelCubit>()),
    BlocProvider<ExcelUploadBloc>(
        create: (context) => serviceLocator<ExcelUploadBloc>()),
  ];
}
