import 'package:gas_app/core/network/exceptions/app_exception.dart';

class NoInternetException extends AppException {
  const NoInternetException() : super('No internet connection');
}

class TimeoutException extends AppException {
  const TimeoutException() : super('Request timeout');
}

class UnauthorizedException extends AppException {
  const UnauthorizedException() : super('Unauthorized');
}

class ServerException extends AppException {
  const ServerException() : super('Server error');
}

class UnknownNetworkException extends AppException {
  const UnknownNetworkException() : super('Unexpected error');
}
