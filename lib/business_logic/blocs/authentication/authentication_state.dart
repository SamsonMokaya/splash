part of 'authentication_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class AuthenticationLoding extends AuthState {
  @override
  List<Object> get props => [];
}

class LoginInProgress extends AuthState {}

class RegistrationInProgress extends AuthState {}

class AuthenticationSuccess extends AuthState {
  final UserModel user;
  const AuthenticationSuccess({required this.user});
  @override
  List<Object> get props => [user];
}

class AuthenticationError extends AuthState {
  final String errorMessage;
  const AuthenticationError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
