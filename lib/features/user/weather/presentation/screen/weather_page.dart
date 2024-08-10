import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newtok_weather/core/utils/appbar_title.dart';
import 'package:newtok_weather/features/user/weather/presentation/bloc/weather_bloc.dart';
import 'package:newtok_weather/features/user/weather/presentation/widget/weather_card.dart';

import '../../../../../core/entity/location_entity.dart';
import '../../../../../core/utils/app_text.dart';
import '../../../../../core/utils/loader.dart';

class WeatherPage extends StatefulWidget {
  final LocationEntity entity;
  const WeatherPage({super.key, required this.entity});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherBloc>().add(GetWeather(place: widget.entity.city));
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: AppbarTitle(title: 'Weather'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              BlocConsumer<WeatherBloc, WeatherState>(
                  builder: (context, user) {
                    if (user is WeatherLoaded) {
                      return WeatherCard(
                          city: widget.entity.city,
                          temperature: user.weather.current.dewpointC ?? 0,
                          weatherIconUrl:
                              user.weather.current.condition.icon ?? '',
                          weatherDescription:
                              user.weather.current.condition.text ?? '',
                          time: user.weather.current.lastUpdated ?? '',
                          uvIndex: user.weather.current.uv ?? 0,
                          rainPercentage: user.weather.current.cloud ?? 0,
                          airQuality:
                              user.weather.current.pressureMb?.toInt() ?? 1);
                    }
                    if (user is WeatherError) {
                      return Center(
                        child: AppText(
                          text: user.failure.message,
                          textStyle: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 3,
                        ),
                      );
                    }
                    return const Center(
                      child: Loader(),
                    );
                  },
                  listener: (context, location) {})
            ],
          ),
        ),
      ),
    );
  }
}
