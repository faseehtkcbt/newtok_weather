import 'package:fpdart/fpdart.dart';
import 'package:newtok_weather/core/failure/failures.dart';

abstract interface class LocationAddRepository {
  Future<Either<Failures, String>> addLocation({
    required String country,
    required String state,
    required String district,
    required String city,
  });
}
