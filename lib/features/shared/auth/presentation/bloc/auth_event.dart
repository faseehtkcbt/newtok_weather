part of 'auth_bloc.dart';

abstract class AuthEvent {}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String role;
  RegisterEvent({
    required this.name,
    required this.password,
    required this.email,
    required this.role,

  });
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  LoginEvent({
    required this.password,
    required this.email,
  });
}
