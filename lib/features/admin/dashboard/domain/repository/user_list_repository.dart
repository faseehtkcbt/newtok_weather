import 'package:fpdart/fpdart.dart';
import 'package:newtok_weather/core/entity/location_entity.dart';
import 'package:newtok_weather/core/entity/user_entity.dart';
import 'package:newtok_weather/core/failure/failures.dart';

abstract interface class UserListRepository{
  Future<Either<Failures,List<UserEntity>>>  getUsers();
}