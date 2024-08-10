import 'package:fpdart/src/either.dart';
import 'package:newtok_weather/core/exception/exceptions.dart';
import 'package:newtok_weather/core/failure/failures.dart';
import 'package:newtok_weather/features/admin/location_add_page/data/datasource/location_add_data_source.dart';
import 'package:newtok_weather/features/admin/location_add_page/domain/repository/location_add_repository.dart';

class LocationAddRepoImpl implements LocationAddRepository {
  final LocationAddDataSource dataSource;
  LocationAddRepoImpl({required this.dataSource});
  @override
  Future<Either<Failures, String>> addLocation(
      {required String country,
      required String state,
      required String district,
      required String city}) async {
    try {
      final result = await dataSource.addLocation(
          country: country, state: state, district: district, city: city);
      return Right(result);
    } on ServerExceptions catch (e) {
      return Left(Failures(message: e.exception));
    } catch (e) {
      return Left(Failures(message: e.toString()));
    }
  }
}
