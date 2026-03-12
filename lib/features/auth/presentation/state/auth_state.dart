import 'package:gas_app/features/auth/domain/entities/user.dart';

enum AuthStateStatus { initial, loading, authenticated, unauthenticated, error }

enum AuthErrorType { unknown, invalidCredentials, network }

enum AuthScreen { login, register }

class AuthState {
  final AuthStateStatus status;
  final User? user;
  final AuthErrorType? errorType;
  final AuthScreen screen;
  final String selectedFuel;
  final double tankSize;

  const AuthState({
    this.status = AuthStateStatus.initial,
    this.user,
    this.errorType,
    this.screen = AuthScreen.login,
    this.selectedFuel = 'gasoline95',
    this.tankSize = 50,
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

  factory AuthState.loginScreen() => const AuthState(screen: AuthScreen.login);

  factory AuthState.registerScreen() =>
      const AuthState(screen: AuthScreen.register);

  AuthState copyWith({
    AuthStateStatus? status,
    User? user,
    AuthErrorType? errorType,
    AuthScreen? screen,
    String? selectedFuel,
    double? tankSize,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorType: errorType ?? this.errorType,
      screen: screen ?? this.screen,
      selectedFuel: selectedFuel ?? this.selectedFuel,
      tankSize: tankSize ?? this.tankSize,
    );
  }
}
