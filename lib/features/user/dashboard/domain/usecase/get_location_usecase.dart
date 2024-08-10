import 'package:fpdart/fpdart.dart';
import 'package:newtok_weather/core/entity/location_entity.dart';
import 'package:newtok_weather/core/failure/failures.dart';
import 'package:newtok_weather/core/usecase/usecase.dart';
import 'package:newtok_weather/features/user/dashboard/domain/repository/location_repository.dart';

class GetLocationUsecase implements Usecase<List<LocationEntity>, NoParam> {
  final LocationRepository repository;

  GetLocationUsecase({required this.repository});
  @override
  Future<Either<Failures, List<LocationEntity>>> call(NoParam params) async {
    // TODO: implement call
    return await repository.getLocations();
  }
}
