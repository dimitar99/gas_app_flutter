import 'package:gas_app/features/gas_stations/domain/entities/gas_station.dart';

enum GasStationsStatus { initial, loading, success, error }

class GasStationsState {
  final GasStationsStatus status;
  final List<GasStation> gasStations;
  final List<GasStation> filteredGasStations;

  const GasStationsState({
    this.status = GasStationsStatus.initial,
    this.gasStations = const [],
    this.filteredGasStations = const [],
  });

  factory GasStationsState.initial() => const GasStationsState();

  factory GasStationsState.loading() =>
      const GasStationsState(status: GasStationsStatus.loading);

  factory GasStationsState.success(
    List<GasStation> gasStations, {
    List<GasStation> filteredGasStations = const [],
  }) => GasStationsState(
    status: GasStationsStatus.success,
    gasStations: gasStations,
    filteredGasStations: gasStations,
  );

  factory GasStationsState.error() =>
      const GasStationsState(status: GasStationsStatus.error);
}
