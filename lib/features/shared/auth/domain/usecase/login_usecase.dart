import 'package:fpdart/fpdart.dart';

import '../../../../../core/entity/user_entity.dart';
import '../../../../../core/failure/failures.dart';
import '../../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class LoginUseCase implements Usecase<UserEntity, LoginParams> {
  AuthRepository authRepository;
  LoginUseCase(this.authRepository);
  @override
  Future<Either<Failures, UserEntity>> call(LoginParams params) async {
    return await authRepository.loginUser(
        email: params.email, password: params.password);
  }
}

class LoginParams {
  final String email;
  final String password;
  LoginParams({
    required this.password,
    required this.email,
  });
}
