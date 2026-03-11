import 'package:gas_app/features/auth/domain/entities/user.dart';
import 'package:gas_app/features/auth/domain/respositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<User> call({required String email, required String password}) {
    return repository.login(email: email, password: password);
  }
}
