import 'package:dio/dio.dart';
import 'package:gas_app/core/network/error_mapper.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final exception = DioErrorMapper.map(err);
    handler.reject(
      DioException(requestOptions: err.requestOptions, error: exception),
    );
  }
}
