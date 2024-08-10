import 'package:fpdart/fpdart.dart';
import 'package:newtok_weather/core/entity/location_entity.dart';
import 'package:newtok_weather/core/exception/exceptions.dart';
import 'package:newtok_weather/core/failure/failures.dart';
import 'package:newtok_weather/features/user/dashboard/data/datasource/location_datasource.dart';
import 'package:newtok_weather/features/user/dashboard/domain/repository/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDatasource datasource;

  LocationRepositoryImpl({required this.datasource});
  @override
  Future<Either<Failures, List<LocationEntity>>> getLocations() async {
    try {
      final response = await datasource.getLocations();
      return Right(response);
    } on ServerExceptions catch (e) {
      return Left(Failures(message: e.exception));
    }
  }
}
