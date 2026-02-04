import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gas_app/core/network/providers/dio_provider.dart';
import 'package:gas_app/core/storage/token_storage.dart';
import 'package:gas_app/core/storage/user_storage.dart';
import 'package:gas_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:gas_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:gas_app/features/auth/domain/respositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRemoteDatasourceProvider = Provider<AuthRemoteDatasource>((ref) {
  final dio = ref.read(dioProvider);
  return AuthRemoteDatasource(dio);
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  const secureStorage = FlutterSecureStorage();
  return SecureTokenStorage(secureStorage);
});

final userStorageProvider = Provider<UserStorage>((ref) {
  final prefs = ref.read(sharedPreferencesProvider);
  return LocalUserStorage(prefs);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remote = ref.read(authRemoteDatasourceProvider);
  final tokenStorage = ref.read(tokenStorageProvider);
  final userStorage = ref.read(userStorageProvider);

  return AuthRepositoryImpl(remote, tokenStorage, userStorage);
});
