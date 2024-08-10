import 'package:flutter/material.dart';
import 'package:newtok_weather/features/admin/dashboard/presentation/screen/admin_dashboard.dart';
import 'package:newtok_weather/features/user/dashboard/presentation/screen/user_dashboard.dart';
import 'package:newtok_weather/features/user/excel/presentation/screen/add_excel_page.dart';

import '../../features/admin/location_add_page/presentation/screen/location_add_page.dart';
import '../../features/shared/auth/presentation/pages/sign_in_page.dart';
import '../../features/shared/auth/presentation/pages/sign_up_page.dart';

class Routes {
  Routes._();

  static const String signUpPage = '/sign_up_page';
  static const String signInPage = '/sign_in_page';
  static const String locationAddPage = '/location_add_page';
  static const String adminDashboard = '/admin_dashboard';
  static const String userDashboard = '/user_dashboard';
  static const String addExcelPage = '/add_excel_page';



  static final dynamic route = <String, WidgetBuilder>{
    signUpPage: (BuildContext context) => const SignUpPage(),
    signInPage: (BuildContext context) => const SignInPage(),
    locationAddPage : (BuildContext context) => const LocationAddPage(),
    adminDashboard:(BuildContext context) => const AdminDashboard(),
    userDashboard:(BuildContext context) => const UserDashboard(),
    addExcelPage:(BuildContext context) => const AddExcelPage(),

  };
}
