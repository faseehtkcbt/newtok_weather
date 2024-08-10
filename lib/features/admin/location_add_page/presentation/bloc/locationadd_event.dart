part of 'locationadd_bloc.dart';

abstract class LocationAddEvent {}

class AddLocation extends LocationAddEvent {
  final String country;
  final String state;
  final String district;
  final String city;
  AddLocation(
      {required this.country,
      required this.state,
      required this.district,
      required this.city});
}
