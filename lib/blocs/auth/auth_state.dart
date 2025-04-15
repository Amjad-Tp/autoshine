part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String userId;
  const AuthSuccess({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class AuthFailed extends AuthState {
  final String error;

  const AuthFailed({required this.error});

  @override
  List<Object?> get props => [error];
}

class AuthVerificationEmailSent extends AuthState {
  final String message;
  const AuthVerificationEmailSent(this.message);
}
