import 'package:newtok_weather/features/user/weather/domain/entity/current_location_entity.dart';

class CurrentLocationModel extends CurrentLocationEntity {
  CurrentLocationModel(
      {required super.name,
      required super.region,
      required super.country,
      required super.lat,
      required super.lon,
      required super.tzId,
      required super.localtimeEpoch,
      required super.localtime});

  factory CurrentLocationModel.fromJson(Map<String, dynamic> map) {
    return CurrentLocationModel(
      name: map['name'] ?? '',
      region: map['region'] ?? '',
      country: map['country'] ?? '',
      lat: map['lat']?.toDouble() ?? 0.0,
      lon: map['lon']?.toDouble() ?? 0.0,
      tzId: map['tz_id'] ?? '',
      localtimeEpoch: map['localtime_epoch'] ?? 0,
      localtime: map['localtime'] ?? '',
    );
  }
}
