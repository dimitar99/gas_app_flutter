import 'package:gas_app/features/auth/domain/respositories/auth_repository.dart';

class RefreshTokenUseCase {
  final AuthRepository repository;

  RefreshTokenUseCase(this.repository);

  Future<bool> call(String refreshToken) =>
      repository.refreshToken(refreshToken);
}
