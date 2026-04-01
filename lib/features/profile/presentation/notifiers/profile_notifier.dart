import 'package:gas_app/features/auth/presentation/providers/auth_providers.dart';
import 'package:gas_app/features/gas_stations/presentation/notifiers/gas_stations_notifier.dart';
import 'package:gas_app/features/profile/presentation/providers/profile_usecases_provider.dart';
import 'package:gas_app/features/profile/presentation/state/profile_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_notifier.g.dart';

@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  @override
  ProfileState build() {
    Future.microtask(() => loadData());
    return ProfileState.initial();
  }

  Future<void> loadData({bool reloadGasStations = false}) async {
    state = ProfileState.loading();

    final user = await ref.read(userStorageProvider).getUser();

    if (user == null) {
      state = ProfileState.error();
    } else {
      state = ProfileState.success(
        user.fuel,
        user.tankSize.toDouble(),
        user.searchRadius.toDouble(),
        reloadGasStations,
      );

      if (reloadGasStations) {
        ref
            .read(gasStationsNotifierProvider.notifier)
            .loadNearby(radius: user.searchRadius.toDouble());
      }
    }
  }

  bool isEditing() => state.status == ProfileStatus.editing;

  void toggleEditing() {
    state = state.status != ProfileStatus.editing
        ? state.copyWith(status: ProfileStatus.editing)
        : state.copyWith(
            status: ProfileStatus.success,
            fuel: state.initialFuel,
            tankSize: state.initialTankSize,
            radius: state.radius,
          );
  }

  void updateFuel(String fuel) {
    state = state.copyWith(fuel: fuel);
  }

  void updateTankSize(double tankSize) {
    state = state.copyWith(tankSize: tankSize);
  }

  void updateRadio(double radius) {
    state = state.copyWith(radius: radius);
  }

  Future<void> updatePreferences(
    String fuel,
    double tankSize,
    double radius,
  ) async {
    state = ProfileState.loading();

    final resp = await ref
        .read(updatePreferencesUseCaseProvider)
        .call(fuel, tankSize, radius);
    if (resp) {
      await loadData(reloadGasStations: true);
    } else {
      state = ProfileState.error();
    }
  }
}
