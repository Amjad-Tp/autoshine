part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthSignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;

  AuthSignUpRequested({
    required this.email,
    required this.password,
    required this.name,
  });

  @override
  List<Object> get props => [email, password, name];
}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  AuthLoginRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthResendVerificationEmail extends AuthEvent {}

class AuthLogoutRequested extends AuthEvent {}
