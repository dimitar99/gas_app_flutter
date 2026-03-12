import 'package:gas_app/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login({required String email, required String password});
  Future<User> register({
    required String email,
    required String password,
    required String fuel,
    required double tankSize,
  });
  Future<bool> refreshToken(String refreshToken);
  Future<void> logout();
}
