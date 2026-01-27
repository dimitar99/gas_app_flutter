import 'package:gas_app/features/gas_stations/domain/entities/gas_station.dart';

abstract class GasStationRepository {
  Future<List<GasStation>> getNearbyGasStations({
    required double lat,
    required double lng,
    required double radius,
  });
}
