import 'package:gas_app/core/network/exceptions/network_exception.dart';
import 'package:gas_app/features/auth/presentation/state/auth_state.dart';

class AuthErrorTypeMapper {
  static AuthErrorType fromException(exception) {
    if (exception is! Exception) {
      return AuthErrorType.unknown;
    }
    if (exception is UnauthorizedException) {
      return AuthErrorType.invalidCredentials;
    } else if (exception is NoInternetException) {
      return AuthErrorType.network;
    } else {
      return AuthErrorType.unknown;
    }
  }
}
