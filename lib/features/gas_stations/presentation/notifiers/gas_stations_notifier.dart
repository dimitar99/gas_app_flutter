import 'dart:developer';

import 'package:gas_app/core/location/location_provider.dart';
import 'package:gas_app/features/gas_stations/domain/entities/gas_station.dart';
import 'package:gas_app/features/gas_stations/presentation/providers/gas_stations_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:gas_app/features/gas_stations/domain/usecases/get_gas_stations.dart';
import 'package:gas_app/features/gas_stations/presentation/state/gas_stations_state.dart';

part 'gas_stations_notifier.g.dart';

@riverpod
class GasStationsNotifier extends _$GasStationsNotifier {
  @override
  GasStationsState build() {
    Future.microtask(() => loadNearby());
    return GasStationsState.initial();
  }

  Future<void> loadNearby({double radius = 5}) async {
    state = GasStationsState.loading();

    try {
      final GetNearbyGasStations nearbyGasStations = ref.read(
        nearbyGasStationsProvider,
      );

      final location = await ref.read(locationProvider.future);

      final List<GasStation> stations = await nearbyGasStations.call(
        lat: location.latitude,
        lng: location.longitude,
        radius: radius,
      );

      state = GasStationsState.success(stations);
    } catch (e, stackTrace) {
      log(
        'Error loading nearby gas stations',
        error: e,
        stackTrace: stackTrace,
      );
      state = GasStationsState.error(
        'Error obteniendo las gasolineras cercanas',
      );
    }
  }

  GasStation? getGasStationById(String id) {
    try {
      final gasStation = state.filteredGasStations.firstWhere(
        (station) => station.id == id,
      );
      return gasStation;
    } catch (e) {
      return null;
    }
  }
}
