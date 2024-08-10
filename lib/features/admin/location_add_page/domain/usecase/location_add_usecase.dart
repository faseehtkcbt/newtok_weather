import 'package:fpdart/src/either.dart';
import 'package:newtok_weather/core/failure/failures.dart';
import 'package:newtok_weather/core/usecase/usecase.dart';
import 'package:newtok_weather/features/admin/location_add_page/domain/repository/location_add_repository.dart';

class LocationAddUsecase implements Usecase<String, LocationAddParams> {
  final LocationAddRepository repo;
  LocationAddUsecase({required this.repo});
  @override
  Future<Either<Failures, String>> call(LocationAddParams params) async {
    return await repo.addLocation(
        country: params.country,
        state: params.state,
        district: params.district,
        city: params.city);
  }
}

class LocationAddParams {
  final String country;
  final String state;
  final String district;
  final String city;
  LocationAddParams(
      {required this.country,
      required this.state,
      required this.district,
      required this.city});
}
