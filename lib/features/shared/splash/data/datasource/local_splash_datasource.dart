import 'package:shared_preferences/shared_preferences.dart';

abstract interface class LocalSplashDatasource {
  String checkLoggedIn();
}

class LocalSplashDatasourceImpl implements LocalSplashDatasource {
  final SharedPreferences pref;
  LocalSplashDatasourceImpl(this.pref,);

  @override
  String checkLoggedIn() {
    final data = pref.getString('role');
    if (data == null) {
      return 'none';
    } else {
      return data;
    }
  }

}
