import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gas_app/core/network/error_mapper.dart';
import 'package:gas_app/core/network/exceptions/network_exception.dart';
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
  Future<User> login({required String email, required String password}) async {
    try {
      final response = await remoteDatasource.login(email, password);

      await tokenStorage.saveAccessToken(
        response.accessToken,
        response.accessTokenExpirationDate,
      );
      await tokenStorage.saveRefreshToken(
        response.refreshToken,
        response.refreshTokenExpirationDate,
      );
      await userStorage.saveUser(response.user.toEntity());

      return response.user.toEntity();
    } on DioException catch (e) {
      throw DioErrorMapper.map(e);
    } catch (_) {
      throw const UnknownNetworkException();
    }
  }

  @override
  Future<User> register({
    required String email,
    required String password,
    required String fuel,
    required double tankSize,
  }) async {
    try {
      final response = await remoteDatasource.register(
        email: email,
        password: password,
        fuel: fuel,
        tankSize: tankSize,
      );

      await tokenStorage.saveAccessToken(
        response.accessToken,
        response.accessTokenExpirationDate,
      );
      await tokenStorage.saveRefreshToken(
        response.refreshToken,
        response.refreshTokenExpirationDate,
      );
      await userStorage.saveUser(response.user.toEntity());

      return response.user.toEntity();
    } on DioException catch (e) {
      throw DioErrorMapper.map(e);
    } catch (_) {
      throw const UnknownNetworkException();
    }
  }

  @override
  Future<bool> refreshToken(String refreshToken) async {
    try {
      final response = await remoteDatasource.refreshToken(refreshToken);
      await tokenStorage.saveAccessToken(
        response.accessToken,
        response.accessTokenExpirationDate,
      );
      await tokenStorage.saveRefreshToken(
        response.refreshToken,
        response.refreshTokenExpirationDate,
      );
      return true;
    } on DioException catch (e) {
      log('Refresh failed', name: 'AUTH_REPO', error: e);
      throw DioErrorMapper.map(e);
    } catch (e) {
      log('Unknown refresh error', name: 'AUTH_REPO', error: e);
      throw const UnknownNetworkException();
    }
  }

  @override
  Future<void> logout() async {
    await tokenStorage.clear();
    await userStorage.clear();
  }
}
