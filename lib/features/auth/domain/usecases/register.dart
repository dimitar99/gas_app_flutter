import 'package:gas_app/features/auth/domain/entities/user.dart';
import 'package:gas_app/features/auth/domain/respositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<User> call({
    required String email,
    required String password,
    required String fuel,
    required double tankSize,
  }) {
    return repository.register(
      email: email,
      password: password,
      fuel: fuel,
      tankSize: tankSize,
    );
  }
}
