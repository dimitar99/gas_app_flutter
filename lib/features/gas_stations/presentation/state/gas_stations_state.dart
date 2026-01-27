import 'package:gas_app/features/gas_stations/domain/entities/gas_station.dart';

enum GasStationsStatus { initial, loading, success, error }

class GasStationsState {
  final GasStationsStatus status;
  final List<GasStation> gasStations;
  final List<GasStation> filteredGasStations;
  final String? errorMessage;

  const GasStationsState({
    required this.status,
    this.gasStations = const [],
    this.filteredGasStations = const [],
    this.errorMessage,
  });

  factory GasStationsState.initial() {
    return const GasStationsState(status: GasStationsStatus.initial);
  }

  factory GasStationsState.loading() {
    return const GasStationsState(status: GasStationsStatus.loading);
  }

  factory GasStationsState.success(
    List<GasStation> gasStations, {
    List<GasStation> filteredGasStations = const [],
  }) {
    return GasStationsState(
      status: GasStationsStatus.success,
      gasStations: gasStations,
      filteredGasStations: gasStations,
    );
  }

  factory GasStationsState.error(String message) {
    return GasStationsState(
      status: GasStationsStatus.error,
      errorMessage: message,
    );
  }
}
