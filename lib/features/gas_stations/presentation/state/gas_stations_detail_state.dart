import 'package:gas_app/features/gas_stations/domain/entities/gas_station.dart';

enum GasStationsDetailStatetatus { initial, loading, success, error }

class GasStationsDetailState {
  final GasStationsDetailStatetatus status;
  final GasStation? gasStation;
  final String? userFuel;

  const GasStationsDetailState({
    this.status = GasStationsDetailStatetatus.initial,
    this.gasStation,
    this.userFuel,
  });

  factory GasStationsDetailState.initial() => const GasStationsDetailState();

  factory GasStationsDetailState.loading() =>
      const GasStationsDetailState(status: GasStationsDetailStatetatus.loading);

  factory GasStationsDetailState.success(
    GasStation gasStation,
    String? userFuel,
  ) => GasStationsDetailState(
    status: GasStationsDetailStatetatus.success,
    gasStation: gasStation,
    userFuel: userFuel,
  );

  factory GasStationsDetailState.error() =>
      const GasStationsDetailState(status: GasStationsDetailStatetatus.error);
}
