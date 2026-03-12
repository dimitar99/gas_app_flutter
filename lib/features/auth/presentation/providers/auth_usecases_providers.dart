import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gas_app/features/auth/domain/usecases/login.dart';
import 'package:gas_app/features/auth/domain/usecases/logout.dart';
import 'package:gas_app/features/auth/domain/usecases/refresh_token.dart';
import 'package:gas_app/features/auth/domain/usecases/register.dart';
import 'package:gas_app/features/auth/presentation/providers/auth_providers.dart';

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return LoginUseCase(repository);
});

final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return RegisterUseCase(repository);
});

final refreshTokenUseCaseProvider = Provider<RefreshTokenUseCase>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return RefreshTokenUseCase(repository);
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return LogoutUseCase(repository);
});
