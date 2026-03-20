import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gas_app/core/location/location_provider.dart';
import 'package:gas_app/core/network/providers/dio_provider.dart';
import 'package:gas_app/features/gas_stations/data/datasources/gas_stations_remote_datasource.dart';
import 'package:gas_app/features/gas_stations/data/repositories/gas_station_repository_impl.dart';
import 'package:gas_app/features/gas_stations/domain/entities/gas_station.dart';
import 'package:gas_app/features/gas_stations/domain/respositories/gas_station_repository.dart';
import 'package:gas_app/features/gas_stations/domain/usecases/get_gas_stations.dart';
import 'package:gas_app/features/gas_stations/presentation/notifiers/gas_stations_notifier.dart';

final gasNearbyStationsRemoteDataSourceProvider =
    Provider<GasStationsRemoteDatasource>((ref) {
      final dio = ref.read(dioProvider);
      return GasStationsRemoteDatasourceImpl(dio);
    });

final gasNearbyStationsRepositoryProvider = Provider<GasStationRepository>((
  ref,
) {
  final remoteDatasource = ref.read(gasNearbyStationsRemoteDataSourceProvider);
  return GasStationRepositoryImpl(remoteDatasource: remoteDatasource);
});

final nearbyGasStationsProvider = Provider<GetNearbyGasStations>((ref) {
  final repo = ref.read(gasNearbyStationsRepositoryProvider);
  return GetNearbyGasStations(repo);
});

final gasStationsSearchQueryProvider = StateProvider<String>((ref) => '');

final filteredGasStationsProvider = Provider<List<GasStation>>((ref) {
  final query = ref.watch(gasStationsSearchQueryProvider).trim().toLowerCase();
  final state = ref.watch(gasStationsNotifierProvider);
  final location = ref.watch(locationProvider).value;
  final all = state.gasStations;

  if (location == null) return all;

  final allWithDistance = all.map((g) {
    return g.copyWith(
      distance: g.calculateDistance(location.latitude, location.longitude),
    );
  }).toList();

  if (query.isEmpty) return allWithDistance;

  return allWithDistance.where((g) {
    final combined = '${g.name} ${g.address} ${g.city} ${g.province}'
        .toLowerCase();
    return combined.contains(query);
  }).toList();
});
