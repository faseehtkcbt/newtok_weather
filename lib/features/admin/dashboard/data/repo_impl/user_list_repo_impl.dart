import 'package:fpdart/fpdart.dart';
import 'package:newtok_weather/core/entity/user_entity.dart';
import 'package:newtok_weather/core/exception/exceptions.dart';
import 'package:newtok_weather/core/failure/failures.dart';
import '../../domain/repository/user_list_repository.dart';
import '../datasource/user_list_datasource.dart';

class UserListRepositoryImpl implements UserListRepository {
  final UserListDatasource datasource;

  UserListRepositoryImpl({required this.datasource});
  @override
  Future<Either<Failures, List<UserEntity>>> getUsers() async {
    try {
      final response = await datasource.getUsers();
      return Right(response);
    } on ServerExceptions catch (e) {
      return Left(Failures(message: e.exception));
    }
  }
}
