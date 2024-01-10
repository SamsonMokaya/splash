part of 'authentication_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StartApp extends AuthEvent {}

class Login extends AuthEvent {
  final String username;
  final String password;

  Login({required this.username, required this.password});
  @override
  List<Object> get props => [username, password];
}

class Register extends AuthEvent {
  final String admisionNumber;
  final String email;
  final String firstName;
  final String lastName;
  final String password;

  Register({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.admisionNumber,
  });
  @override
  List<Object> get props =>
      [email, firstName, lastName, password, admisionNumber];
}

class LogOut extends AuthEvent {}

class UpdateUserProfile extends AuthEvent {}
