import 'package:dio/dio.dart';
import 'package:gas_app/core/network/exceptions/network_exception.dart';

class DioErrorMapper {
  static Exception map(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const TimeoutException();

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;

        if (statusCode == 401 || statusCode == 403) {
          return const UnauthorizedException();
        }

        if (statusCode != null && statusCode >= 500) {
          return const ServerException();
        }

        return const UnknownNetworkException();

      case DioExceptionType.connectionError:
        return const NoInternetException();

      default:
        return const UnknownNetworkException();
    }
  }
}
