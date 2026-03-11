import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gas_app/features/auth/presentation/providers/auth_providers.dart';

class AuthInterceptor extends Interceptor {
  final Ref ref;
  final Dio dio;

  AuthInterceptor(this.ref, this.dio);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await ref.read(tokenStorageProvider).getAccessToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // TODO: implement refresh token
    if (err.response?.statusCode == 401) {
      try {
        // await ref.read(tokenStorageProvider).getRefreshToken();

        final newToken = await ref.read(tokenStorageProvider).getAccessToken();

        err.requestOptions.headers['Authorization'] = 'Bearer $newToken';

        final resp = await dio.fetch(err.requestOptions);

        return handler.resolve(resp);
      } catch (_) {
        // Falló el refresh → seguimos el error original
      }
    }

    handler.next(err);
  }
}
