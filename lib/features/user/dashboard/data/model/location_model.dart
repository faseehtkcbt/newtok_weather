import 'package:newtok_weather/core/entity/location_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel(
      {required super.country,
      required super.state,
      required super.district,
      required super.city});

  factory LocationModel.fromJson(Map<String, dynamic> map) {
    return LocationModel(
        country: map['country'] ?? '',
        state: map['state'] ?? '',
        district: map['district'] ?? '',
        city: map['city']);
  }

  LocationModel copyWith(
      {String? country, String? district, String? city, String? state}) {
    return LocationModel(
      country: country ?? this.country,
      district: district ?? this.district,
      city: city ?? this.city,
      state: state ?? this.state,
    );
  }
}
