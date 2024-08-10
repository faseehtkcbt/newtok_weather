import 'package:fpdart/fpdart.dart';

import '../../../../../core/failure/failures.dart';
import '../../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class RegisterUseCase implements Usecase<String, RegisterParams> {
  AuthRepository authRepository;
  RegisterUseCase(this.authRepository);
  @override
  Future<Either<Failures, String>> call(RegisterParams params) async {
    return await authRepository.registerUser(
        name: params.name, email: params.email, password: params.password,role: params.role);
  }
}

class RegisterParams {
  final String name;
  final String email;
  final String password;
  final String role;
  RegisterParams({
    required this.email,
    required this.password,
    required this.name,
    required this.role
  });
}
