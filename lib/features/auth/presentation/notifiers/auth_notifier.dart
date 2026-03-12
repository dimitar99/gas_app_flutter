import 'package:gas_app/features/auth/presentation/providers/auth_providers.dart';
import 'package:gas_app/features/auth/presentation/providers/auth_usecases_providers.dart';
import 'package:gas_app/features/auth/presentation/state/auth_error_type_mapper.dart';
import 'package:gas_app/features/auth/presentation/state/auth_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() => AuthState.initial();

  Future<void> checkSession() async {
    final isValidAccessToken = await ref
        .read(tokenStorageProvider)
        .isValidAccessToken();
    final user = await ref.read(userStorageProvider).getUser();

    if (isValidAccessToken && user != null) {
      state = AuthState.authenticated(user);
    } else {
      state = AuthState.unauthenticated();
    }
  }

  void changeScreen() {
    if (state.screen == AuthScreen.login) {
      state = AuthState.registerScreen();
    } else {
      state = AuthState.loginScreen();
    }
  }

  void setFuel(String fuel) {
    state = state.copyWith(selectedFuel: fuel);
  }

  void setTankSize(double tankSize) {
    state = state.copyWith(tankSize: tankSize);
  }

  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(status: AuthStateStatus.loading);
    try {
      final user = await ref
          .read(loginUseCaseProvider)
          .call(email: email, password: password);
      state = state.copyWith(status: AuthStateStatus.authenticated, user: user);
    } catch (e) {
      state = state.copyWith(
        status: AuthStateStatus.error,
        errorType: AuthErrorTypeMapper.fromException(e),
      );
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String fuel,
    required double tankSize,
  }) async {
    state = state.copyWith(status: AuthStateStatus.loading);
    try {
      final user = await ref
          .read(registerUseCaseProvider)
          .call(
            email: email,
            password: password,
            fuel: fuel,
            tankSize: tankSize,
          );
      state = state.copyWith(status: AuthStateStatus.authenticated, user: user);
    } catch (e) {
      state = state.copyWith(
        status: AuthStateStatus.error,
        errorType: AuthErrorTypeMapper.fromException(e),
      );
    }
  }

  Future<void> logout() async {
    state = AuthState.unauthenticated();
    await ref.read(logoutUseCaseProvider).call();
  }
}
