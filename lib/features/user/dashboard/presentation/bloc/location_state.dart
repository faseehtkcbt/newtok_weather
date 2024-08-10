part of 'location_bloc.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final List<LocationEntity> data;
  LocationLoaded({required this.data});
}

class LocationError extends LocationState {
  final Failures failure;
  LocationError({required this.failure});
}
