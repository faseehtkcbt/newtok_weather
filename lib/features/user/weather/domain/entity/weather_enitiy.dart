import 'current_location_entity.dart';
import 'current_weather_entity.dart';

class WeatherEntity {
  final CurrentLocationEntity location;
  final CurrentWeatherEntity current;

  WeatherEntity({
    required this.location,
    required this.current,
  });
}