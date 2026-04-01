import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gas_app/core/theme/app_spacing.dart';
import 'package:gas_app/core/theme/app_text_styles.dart';
import 'package:gas_app/features/gas_stations/domain/entities/gas_station.dart';
import 'package:gas_app/features/gas_stations/presentation/notifiers/gas_stations_detail_notifier.dart';
import 'package:gas_app/features/gas_stations/presentation/state/gas_stations_detail_state.dart';
import 'package:gas_app/features/gas_stations/presentation/widgets/gas_station_detail_adress.dart';
import 'package:gas_app/features/gas_stations/presentation/widgets/gas_station_detail_how_to_arrive.dart';
import 'package:gas_app/features/gas_stations/presentation/widgets/gas_station_detail_prices_list.dart';
import 'package:gas_app/features/gas_stations/presentation/widgets/gas_station_detail_schedule.dart';

class GasStationsDetailPage extends ConsumerWidget {
  final String gasStationId;
  const GasStationsDetailPage({super.key, required this.gasStationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gasStationDetailNotifierProvider(gasStationId));

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle'), centerTitle: true),
      body: switch (state.status) {
        GasStationsDetailStatetatus.initial ||
        GasStationsDetailStatetatus.loading => const Loading(),
        GasStationsDetailStatetatus.success => GasStationDetail(
          gasStation: state.gasStation!,
          userFuel: state.userFuel,
        ),
        GasStationsDetailStatetatus.error => const Error(),
      },
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: kToolbarHeight),
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class GasStationDetail extends StatelessWidget {
  final GasStation gasStation;
  final String? userFuel;
  const GasStationDetail({
    super.key,
    required this.gasStation,
    required this.userFuel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppVerticalSpacing.s12,

          Text(gasStation.name, style: AppTextStyles.heading1),
          AppVerticalSpacing.s12,

          GasStationDetailAddress(
            address: gasStation.address,
            city: gasStation.city,
            province: gasStation.province,
          ),
          AppVerticalSpacing.s12,

          GasStationDetailPricesList(
            prices: gasStation.prices,
            userFuel: userFuel,
          ),
          AppVerticalSpacing.s12,

          GasStationDetailSchedule(schedule: gasStation.schedule),
          AppVerticalSpacing.s12,

          GasStationDetailHowToArrive(gasStation: gasStation),
        ],
      ),
    );
  }
}

class Error extends StatelessWidget {
  const Error({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: kToolbarHeight),
        child: Text('Ha ocurrido un error'),
      ),
    );
  }
}
