import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/entity/user_entity.dart';
import '../../domain/usecase/login_usecase.dart';
import '../../domain/usecase/register_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase _registerUseCase;
  final LoginUseCase _loginUseCase;
  AuthBloc({
    required RegisterUseCase registerUseCase,
    required LoginUseCase loginUseCase,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) {
      emit(AuthLoading());
    });
    on<RegisterEvent>(_onRegisterEvent);
    on<LoginEvent>(_onLoginEvent);
  }

  void _onRegisterEvent(RegisterEvent event, Emitter<AuthState> emit) async {
    final response = await _registerUseCase(RegisterParams(
        email: event.email, password: event.password, name: event.name,role: event.role));
    response.fold((failure) => emit(AuthError(failure.message)),
        (success) => emit(AuthSuccess<String>(success)));
  }

  void _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    final response = await _loginUseCase(LoginParams(
      email: event.email,
      password: event.password,
    ));
    response.fold((failure) => emit(AuthError(failure.message)),
        (success) => emit(AuthSuccess<UserEntity>(success)));
  }
}
