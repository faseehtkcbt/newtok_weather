import 'package:fpdart/fpdart.dart';

import '../../../../../core/entity/user_entity.dart';
import '../../../../../core/failure/failures.dart';

abstract interface class AuthRepository {
  Future<Either<Failures, String>> registerUser({
    required String name,
    required String email,
    required String password,
    required String role
  });
  Future<Either<Failures, UserEntity>> loginUser({
    required String email,
    required String password,
  });
}
