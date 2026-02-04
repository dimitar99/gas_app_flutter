import 'package:gas_app/features/auth/domain/entities/user.dart';

enum AuthStateStatus { initial, loading, authenticated, unauthenticated, error }

enum AuthErrorType { unknown, invalidCredentials, network }

class AuthState {
  final AuthStateStatus status;
  final User? user;
  final AuthErrorType? errorType;

  const AuthState({
    this.status = AuthStateStatus.initial,
    this.user,
    this.errorType,
  });

  factory AuthState.initial() => const AuthState();

  factory AuthState.loading() =>
      const AuthState(status: AuthStateStatus.loading);

  factory AuthState.authenticated(User user) =>
      AuthState(status: AuthStateStatus.authenticated, user: user);

  factory AuthState.unauthenticated() =>
      const AuthState(status: AuthStateStatus.unauthenticated);

  factory AuthState.error(AuthErrorType errorType) =>
      AuthState(status: AuthStateStatus.error, errorType: errorType);
}
