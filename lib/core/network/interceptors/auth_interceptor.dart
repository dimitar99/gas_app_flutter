import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gas_app/features/auth/presentation/notifiers/auth_notifier.dart';
import 'package:gas_app/features/auth/presentation/providers/auth_providers.dart';

class AuthInterceptor extends QueuedInterceptor {
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
    if (err.response?.statusCode == 401) {
      final success = await ref
          .read(authNotifierProvider.notifier)
          .refreshToken();

      if (success) {
        final newToken = await ref.read(tokenStorageProvider).getAccessToken();

        err.requestOptions.headers['Authorization'] = 'Bearer $newToken';

        try {
          final resp = await dio.fetch(err.requestOptions);
          return handler.resolve(resp);
        } on DioException catch (e) {
          handler.reject(e);
        }
      } else {
        await ref.read(authNotifierProvider.notifier).logout();
        handler.reject(err);
      }
    }

    handler.next(err);
  }
}
