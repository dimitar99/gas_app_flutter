import 'package:gas_app/features/profile/domain/repositories/profile_repository.dart';

class UpdatePreferencesUseCase {
  final ProfileRepository repository;

  UpdatePreferencesUseCase(this.repository);

  Future<bool> call(String fuel, double tankSize, double radius) {
    return repository.updatePreferences(fuel, tankSize, radius);
  }
}
