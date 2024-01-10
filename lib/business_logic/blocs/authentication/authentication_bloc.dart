import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocation_flutter/repositories/authentication/auth_repository.dart';

import '../../../repositories/models/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthenticationLoding()) {
    on<Register>(_onRegister);
    on<StartApp>(_onStartApp);
    on<Login>(_onLogin);
    on<LogOut>(_onLogOut);
  }

  Future<void> _onRegister(Register event, Emitter<AuthState> emit) async {
    emit(RegistrationInProgress());
    try {
      final user = await _authRepository.register(
          email: event.email,
          password: event.password,
          firstName: event.firstName,
          lastName: event.lastName,
          admisionNumber: event.admisionNumber);
      if (user != null) {
        emit(AuthenticationSuccess(user: user));
      } else {
        emit(const AuthenticationError(errorMessage: ''));
      }
    } catch (e) {
      String errorMessage = e.toString().replaceAll('Exception:', '');
      emit(AuthenticationError(errorMessage: errorMessage));
    }
  }

  Future<void> _onLogin(Login event, Emitter<AuthState> emit) async {
    emit(LoginInProgress());
    try {
      final user = await _authRepository.login(
          email: event.username, password: event.password);
      if (user != null) {
        emit(AuthenticationSuccess(user: user));
      } else {
        emit(const AuthenticationError(errorMessage: ''));
      }
    } catch (e) {
      String errorMessage = e.toString().replaceAll('Exception:', '');
      emit(AuthenticationError(errorMessage: errorMessage));
    }
  }

  Future<void> _onLogOut(LogOut event, Emitter<AuthState> emit) async {
    try {
      await _authRepository.logOut();
      emit(AuthenticationSuccess(user: UserModel.empty));
    } catch (e) {
      emit(AuthenticationError(errorMessage: e.toString()));
    }
  }

  Future<void> _onStartApp(StartApp event, Emitter<AuthState> emit) async {
    emit(AuthenticationSuccess(user: UserModel.empty));
  }
}
