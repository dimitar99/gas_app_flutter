import 'dart:developer';
import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('⭕ Dio error → ${err.type} | ${err.response?.statusCode}');

    handler.next(err);
  }
}
