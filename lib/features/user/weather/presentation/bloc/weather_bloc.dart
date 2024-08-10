import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newtok_weather/core/failure/failures.dart';
import 'package:newtok_weather/features/user/weather/domain/entity/weather_enitiy.dart';

import '../../domain/usecase/get_weather_usecase.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherUsecase _weather;
  WeatherBloc(GetWeatherUsecase weather)
      : _weather = weather,
        super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) {
      emit(WeatherLoading());
    });
    on<GetWeather>((event, emit) async {
      final result = await _weather(WeatherParam(place: event.place));
      result.fold((l) => emit(WeatherError(failure: l)),
          (r) => emit(WeatherLoaded(weather: r)));
    });
  }
}
