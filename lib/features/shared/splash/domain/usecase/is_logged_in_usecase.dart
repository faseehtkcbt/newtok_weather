import '../../../../../core/usecase/usecase.dart';
import '../repository/splash_repository.dart';

class IsLoggedInUsecase {
  final SplashRepository local;
  IsLoggedInUsecase(this.local);
  String call(NoParam params) {
    return local.checkLoggedIn();
  }
}
