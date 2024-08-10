part of 'checkloggedin_bloc.dart';

@immutable
abstract class CheckloggedinState {}

class CheckloggedinInitial extends CheckloggedinState {}

class CheckloggedinLoading extends CheckloggedinState {}

class CheckloggedinLoaded extends CheckloggedinState {
  final String role;
  CheckloggedinLoaded(this.role);
}

class CheckloggedinError extends CheckloggedinState {
  final Failures failure;

  CheckloggedinError(this.failure);
}
