import 'package:gas_app/features/auth/presentation/providers/auth_providers.dart';
import 'package:gas_app/features/auth/presentation/state/auth_error_type_mapper.dart';
import 'package:gas_app/features/auth/presentation/state/auth_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() => AuthState.initial();

  Future<void> checkSession() async {
    final token = await ref.read(tokenStorageProvider).getAccessToken();
    final user = await ref.read(userStorageProvider).getUser();

    if (token != null && user != null) {
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

  void setTankCapacity(double tankCapacity) {
    state = state.copyWith(tankCapacity: tankCapacity);
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith();
    try {
      final user = await ref
          .read(authRepositoryProvider)
          .login(email, password);
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(AuthErrorTypeMapper.fromException(e));
    }
  }

  Future<void> register(String email, String password) async {
    state = AuthState.loading();
    try {
      final user = await ref
          .read(authRepositoryProvider)
          .register(email, password);
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(AuthErrorTypeMapper.fromException(e));
    }
  }

  Future<void> logout() async {
    state = AuthState.unauthenticated();
    await ref.read(authRepositoryProvider).logout();
  }
}
