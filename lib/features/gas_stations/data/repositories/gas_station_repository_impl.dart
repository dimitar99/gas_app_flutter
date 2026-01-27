import 'package:gas_app/features/gas_stations/data/datasources/gas_stations_remote_datasource.dart';
import 'package:gas_app/features/gas_stations/domain/entities/gas_station.dart';
import 'package:gas_app/features/gas_stations/domain/respositories/gas_station_repository.dart';

class GasStationRepositoryImpl implements GasStationRepository {
  final GasStationsRemoteDatasource remoteDatasource;

  GasStationRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<GasStation>> getNearbyGasStations({
    required double lat,
    required double lng,
    required double radius,
  }) async {
    final models = await remoteDatasource.getNearby(
      lat: lat,
      lng: lng,
      radius: radius,
    );

    return models.map((e) => e.toEntity()).toList();
  }
}
