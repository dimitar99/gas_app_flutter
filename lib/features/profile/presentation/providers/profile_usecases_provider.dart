import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gas_app/features/profile/domain/usecases/update_preferences.dart';
import 'package:gas_app/features/profile/presentation/providers/profile_providers.dart';

final updatePreferencesUseCaseProvider = Provider<UpdatePreferencesUseCase>((
  ref,
) {
  final repository = ref.read(profileRepositoryProvider);
  return UpdatePreferencesUseCase(repository);
});
