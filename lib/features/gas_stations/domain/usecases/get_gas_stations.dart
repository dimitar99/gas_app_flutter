import 'package:gas_app/features/gas_stations/domain/entities/gas_station.dart';
import 'package:gas_app/features/gas_stations/domain/respositories/gas_station_repository.dart';

class GetNearbyGasStations {
  final GasStationRepository repository;

  GetNearbyGasStations(this.repository);

  Future<List<GasStation>> call({
    required double lat,
    required double lng,
    required double radius,
  }) {
    return repository.getNearbyGasStations(lat: lat, lng: lng, radius: radius);
  }
}
