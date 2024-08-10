part of 'locationadd_bloc.dart';

abstract class LocationAddState {}

final class LocationAddInitial extends LocationAddState {}
final class LocationAddLoading extends LocationAddState {}
final class LocationAddLoaded extends LocationAddState {
  final String message;
  LocationAddLoaded(this.message);
}
final class LocationAddError extends LocationAddState {
  final Failures failure;
  LocationAddError(this.failure);

}


