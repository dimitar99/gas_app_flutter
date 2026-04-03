import 'package:gas_app/features/auth/presentation/providers/auth_providers.dart';
import 'package:gas_app/features/gas_stations/presentation/notifiers/gas_stations_notifier.dart';
import 'package:gas_app/features/gas_stations/presentation/state/gas_stations_detail_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gas_stations_detail_notifier.g.dart';

@riverpod
class GasStationDetailNotifier extends _$GasStationDetailNotifier {
  @override
  GasStationsDetailState build(String id) {
    Future.microtask(() => loadData());
    return GasStationsDetailState.initial();
  }

  void loadData() {
    state = GasStationsDetailState.loading();

    final gasStation = ref
        .read(gasStationsNotifierProvider.notifier)
        .getGasStationById(id);

    if (gasStation == null) {
      state = GasStationsDetailState.error();
    } else {
      final user = ref.read(userStorageProvider).getUser();

      state = GasStationsDetailState.success(gasStation, user?.fuel);
    }
  }
}
