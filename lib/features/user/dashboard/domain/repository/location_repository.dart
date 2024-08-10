import 'package:fpdart/fpdart.dart';
import 'package:newtok_weather/core/entity/location_entity.dart';
import 'package:newtok_weather/core/failure/failures.dart';

abstract interface class LocationRepository{
  Future<Either<Failures,List<LocationEntity>>>  getLocations();
}