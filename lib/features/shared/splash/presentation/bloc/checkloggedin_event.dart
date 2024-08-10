part of 'checkloggedin_bloc.dart';

@immutable
abstract class CheckloggedinEvent {}

class IsLoggedIn extends CheckloggedinEvent {}

class LoggedOut extends CheckloggedinEvent {}
