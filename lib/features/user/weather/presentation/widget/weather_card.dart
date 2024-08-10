import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final String city;
  final double temperature;
  final String weatherIconUrl;
  final String weatherDescription;
  final String time;
  final double uvIndex;
  final int rainPercentage;
  final int airQuality;

  WeatherCard({
    required this.city,
    required this.temperature,
    required this.weatherIconUrl,
    required this.weatherDescription,
    required this.time,
    required this.uvIndex,
    required this.rainPercentage,
    required this.airQuality,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: size.height*0.75,
      width: size.width,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 4.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              'https:$weatherIconUrl',
              height: 100,
            ),
           const SizedBox(height: 8),
            Text(
              city,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${temperature.toStringAsFixed(1)}°',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WeatherDetail(label: "TIME", value: time),
                WeatherDetail(label: "UV", value: uvIndex.toString()),
                WeatherDetail(label: "% RAIN", value: '$rainPercentage%'),
                WeatherDetail(label: "AQ", value: airQuality.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherDetail extends StatelessWidget {
  final String label;
  final String value;

  WeatherDetail({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
