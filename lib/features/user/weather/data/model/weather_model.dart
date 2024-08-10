import 'package:newtok_weather/features/user/weather/data/model/current_location_model.dart';
import 'package:newtok_weather/features/user/weather/data/model/current_weather_model.dart';
import 'package:newtok_weather/features/user/weather/domain/entity/weather_enitiy.dart';

class WeatherModel extends WeatherEntity {
  WeatherModel({required super.location, required super.current});

  factory WeatherModel.fromJson(Map<String, dynamic> map) {
    return WeatherModel(
        location: CurrentLocationModel.fromJson(map['location']),
        current: CurrentWeatherModel.fromJson(map['current']));
  }
}
