import 'dart:convert';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/credentials/credentials.dart';
import '../../../../../core/exception/exceptions.dart';
import '../../../../../core/internet/connection_checker.dart';
import '../model/weather_model.dart';
import 'package:http/http.dart' as http;

abstract interface class WeatherDatasource {
  Future<WeatherModel> getWeatherData({required String place});
}

class WeatherDatasourceImpl implements WeatherDatasource {
  final ConnectionChecker connectionChecker;
  WeatherDatasourceImpl({required this.connectionChecker});

  @override
  Future<WeatherModel> getWeatherData({required String place}) async {
    try {
      if (!(await connectionChecker.isInternetConnected)) {
        throw ServerExceptions(
            'Internet Disconnected!! Please connect the internet.');
      }
      final response = await http.get(
          Uri.parse('${Constants.baseUrl}?q=$place&key=${Credentials.apiKey}'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return WeatherModel.fromJson(data);
      } else {
        throw ServerExceptions(jsonDecode(response.body)['error']['message'] ??
            'Something Went Wrong!!');
      }
    } on ServerExceptions catch (e) {
      throw ServerExceptions(e.exception);
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }
}
