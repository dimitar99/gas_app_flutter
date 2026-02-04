import 'package:gas_app/core/storage/token_storage.dart';
import 'package:gas_app/core/storage/user_storage.dart';
import 'package:gas_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:gas_app/features/auth/domain/entities/user.dart';
import 'package:gas_app/features/auth/domain/respositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  final TokenStorage tokenStorage;
  final UserStorage userStorage;

  AuthRepositoryImpl(
    this.remoteDatasource,
    this.tokenStorage,
    this.userStorage,
  );

  @override
  Future<User> login(String email, String password) async {
    final response = await remoteDatasource.login(email, password);

    await tokenStorage.saveAccessToken(response.accessToken);
    await tokenStorage.saveRefreshToken(response.refreshToken);
    await userStorage.saveUser(response.user.toEntity());

    return response.user.toEntity();
  }

  @override
  Future<User> register(String email, String password) async {
    final response = await remoteDatasource.register(email, password);

    await tokenStorage.saveAccessToken(response.accessToken);
    await tokenStorage.saveRefreshToken(response.refreshToken);
    await userStorage.saveUser(response.user.toEntity());

    return response.user.toEntity();
  }

  @override
  Future<void> logout() async {
    await tokenStorage.clear();
    await userStorage.clear();
    await remoteDatasource.logout();
  }
}
