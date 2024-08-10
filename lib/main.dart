import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newtok_weather/config/route/routes.dart';
import 'package:newtok_weather/config/theme/theme.dart';
import 'package:newtok_weather/features/admin/dashboard/presentation/screen/admin_dashboard.dart';
import 'package:newtok_weather/features/shared/auth/presentation/pages/sign_in_page.dart';
import 'package:newtok_weather/features/shared/splash/presentation/pages/splash_page.dart';
import 'package:newtok_weather/features/user/dashboard/presentation/screen/user_dashboard.dart';

import 'core/bloc/providers/bloc_providers.dart';
import 'init_dependencies.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: BlocProviders.providers,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: Routes.route,
      title: 'Newtok Weather',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}

