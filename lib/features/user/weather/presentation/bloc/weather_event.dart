part of 'weather_bloc.dart';

abstract class WeatherEvent {}

class GetWeather extends WeatherEvent{
  final String place;
  GetWeather({required this.place});
}