import 'package:fpdart/fpdart.dart';
import 'package:newtok_weather/core/failure/failures.dart';
import 'package:newtok_weather/features/user/weather/domain/entity/weather_enitiy.dart';

abstract interface class WeatherRepository{
  Future<Either<Failures,WeatherEntity>> getWeatherData({required String place});
}