import 'package:fpdart/fpdart.dart';

import '../../../../../core/exception/exceptions.dart';
import '../../../../../core/failure/failures.dart';
import '../../../../../core/model/user_model.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/auth_datasource.dart';
import '../datasource/local_auth_datasource.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final AuthDataSource authDataSource;
  final LocalAuthDatasource localData;
  AuthRepositoryImplementation(this.authDataSource, this.localData);
  @override
  Future<Either<Failures, UserModel>> loginUser(
      {required String email, required String password}) async {
    try {
      final userId = await authDataSource.loginUser(
        email: email,
        password: password,
      );
      localData.storeLocalData(userId);
      return right(userId);
    } on ServerExceptions catch (e) {
      return Left(Failures(message: e.exception.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> registerUser(
      {required String name,
      required String email,
      required String password,required String role}) async {
    try {
      final result = await authDataSource.registerUser(
          email: email, password: password, username: name,role: role);
      return Right(result);
    } on ServerExceptions catch (e) {
      return Left(Failures(message: e.exception));
    }
  }
}
