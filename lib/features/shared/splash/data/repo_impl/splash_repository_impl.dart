

import '../../domain/repository/splash_repository.dart';
import '../datasource/local_splash_datasource.dart';

class SplashRepositoryImpl implements SplashRepository {
  final LocalSplashDatasource local;

  SplashRepositoryImpl(this.local);
  @override
  String checkLoggedIn() {
    return local.checkLoggedIn();
  }
}
