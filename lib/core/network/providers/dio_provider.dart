import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gas_app/core/network/interceptors/auth_interceptor.dart';
import 'package:gas_app/core/network/interceptors/error_interceptor.dart';
import 'package:gas_app/core/network/interceptors/logger_interceptor.dart';

BaseOptions dioOptions = BaseOptions(
  connectTimeout: const Duration(seconds: 30),
  receiveTimeout: const Duration(seconds: 30),
  headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
  baseUrl: dotenv.env[Platform.isAndroid ? 'BASE_URL_ANDROID' : 'BASE_URL']!,
);

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(dioOptions);

  dio.interceptors.addAll([
    AuthInterceptor(ref, dio),
    ErrorInterceptor(),
    LoggerInterceptor(),
  ]);

  return dio;
});
