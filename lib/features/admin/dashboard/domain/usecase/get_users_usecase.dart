import 'package:fpdart/fpdart.dart';
import 'package:newtok_weather/core/entity/location_entity.dart';
import 'package:newtok_weather/core/failure/failures.dart';
import 'package:newtok_weather/core/usecase/usecase.dart';

import '../../../../../core/entity/user_entity.dart';
import '../repository/user_list_repository.dart';

class GetUsersUsecase implements Usecase<List<UserEntity>, NoParam> {
  final UserListRepository repository;

  GetUsersUsecase({required this.repository});
  @override
  Future<Either<Failures, List<UserEntity>>> call(NoParam params) async {
    // TODO: implement call
    return await repository.getUsers();
  }
}
