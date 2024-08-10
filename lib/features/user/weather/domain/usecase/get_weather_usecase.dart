import 'package:fpdart/src/either.dart';
import 'package:newtok_weather/core/failure/failures.dart';
import 'package:newtok_weather/core/usecase/usecase.dart';
import 'package:newtok_weather/features/user/weather/domain/entity/weather_enitiy.dart';
import 'package:newtok_weather/features/user/weather/domain/repository/weather_repository.dart';

class GetWeatherUsecase implements Usecase<WeatherEntity,WeatherParam>{
  final WeatherRepository repo;
  GetWeatherUsecase({required this.repo});
  @override
  Future<Either<Failures, WeatherEntity>> call(WeatherParam params) async {
    return await repo.getWeatherData(place: params.place);
  }
}

class WeatherParam{
  final String place;
  WeatherParam({required this.place});

}