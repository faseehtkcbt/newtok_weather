import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/model/user_model.dart';

abstract interface class LocalAuthDatasource {
  void storeLocalData(UserModel user);
}

class LocalAuthDatasourceImpl implements LocalAuthDatasource {
  final SharedPreferences pref;

  LocalAuthDatasourceImpl(this.pref);
  @override
  Future<void> storeLocalData(UserModel user) async {
    pref.setString('email', user.email??'');
    pref.setString('username', user.name??'');
    pref.setString('uid', user.id??'');
    pref.setString('photoUrl', user.photoUrl??'');
    pref.setString('role', user.role??'');
  }
}
