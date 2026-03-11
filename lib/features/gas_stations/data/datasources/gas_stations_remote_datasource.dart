import 'package:dio/dio.dart';
import 'package:gas_app/features/gas_stations/data/dto/gas_station_dto.dart';

abstract class GasStationsRemoteDatasource {
  Future<List<GasStationModelDTO>> getNearby({
    required double lat,
    required double lng,
    required double radius,
  });
}

class GasStationsRemoteDatasourceImpl implements GasStationsRemoteDatasource {
  final Dio dio;
  GasStationsRemoteDatasourceImpl(this.dio);

  @override
  Future<List<GasStationModelDTO>> getNearby({
    required double lat,
    required double lng,
    required double radius,
  }) async {
    final resp = await dio.get(
      "/gas-stations/near-by",
      queryParameters: {"lat": lat, "lng": lng, "kms": radius},
    );

    final List<GasStationModelDTO> gasStations = [];

    resp.data.forEach((e) {
      gasStations.add(GasStationModelDTO.fromJson(e));
    });

    return gasStations;
  }
}
