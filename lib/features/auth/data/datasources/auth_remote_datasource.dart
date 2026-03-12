import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gas_app/features/auth/data/dto/auth_refresh_dto.dart';
import 'package:gas_app/features/auth/data/dto/auth_response_dto.dart';

Dio dio = Dio(
  BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
    baseUrl: dotenv.env[Platform.isAndroid ? 'BASE_URL_ANDROID' : 'BASE_URL']!,
  ),
);

class AuthRemoteDatasource {
  AuthRemoteDatasource();

  Future<AuthResponseDto> login(String email, String password) async {
    final response = await dio.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    return AuthResponseDto.fromJson(response.data);
  }

  Future<AuthRefreshDto> refreshToken(String refreshToken) async {
    final response = await dio.post(
      '/auth/refresh',
      data: {'refreshToken': refreshToken},
    );
    return AuthRefreshDto.fromJson(response.data);
  }

  Future<AuthResponseDto> register({
    required String email,
    required String password,
    required String fuel,
    required double tankSize,
  }) async {
    final response = await dio.post(
      '/auth/register',
      data: {
        'email': email,
        'password': password,
        'fuel': fuel,
        'tankSize': tankSize,
      },
    );

    return AuthResponseDto.fromJson(response.data);
  }
}
