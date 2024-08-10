import 'package:fpdart/src/either.dart';
import 'package:newtok_weather/core/failure/failures.dart';
import 'package:newtok_weather/core/internet/connection_checker.dart';
import 'package:newtok_weather/features/user/weather/data/datasource/weather_datasource.dart';
import 'package:newtok_weather/features/user/weather/domain/entity/weather_enitiy.dart';
import 'package:newtok_weather/features/user/weather/domain/repository/weather_repository.dart';

import '../../../../../core/exception/exceptions.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherDatasource datasource;

  WeatherRepositoryImpl({required this.datasource});
  @override
  Future<Either<Failures, WeatherEntity>> getWeatherData(
      {required String place}) async {
    try {
      final response = await datasource.getWeatherData(place: place);
      return Right(response);
    } on ServerExceptions catch (e) {
      return Left(Failures(message: e.exception));
    }
  }
}
