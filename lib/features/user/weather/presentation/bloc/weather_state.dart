part of 'weather_bloc.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherEntity weather;
  WeatherLoaded({required this.weather});
}

class WeatherError extends WeatherState {
  final Failures failure;
  WeatherError({required this.failure});
}
