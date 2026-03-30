import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gas_app/core/theme/app_spacing.dart';
import 'package:gas_app/features/gas_stations/domain/entities/gas_station.dart';
import 'package:gas_app/features/gas_stations/presentation/notifiers/gas_stations_notifier.dart';
import 'package:gas_app/features/gas_stations/presentation/providers/gas_stations_providers.dart';
import 'package:gas_app/features/gas_stations/presentation/state/gas_stations_state.dart';
import 'package:gas_app/features/gas_stations/presentation/widgets/gas_station_item.dart';
import 'package:go_router/go_router.dart';

class GasStationsPage extends ConsumerWidget {
  const GasStationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gasStationsNotifierProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gasolineras'),
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () => {context.push('/profile')},
            ),
          ],
        ),
        body: switch (state.status) {
          GasStationsStatus.initial => const Loading(),
          GasStationsStatus.loading => const Loading(),
          GasStationsStatus.success => Gasolineras(state: state),
          GasStationsStatus.error => Error(state: state),
        },
      ),
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

class Gasolineras extends ConsumerStatefulWidget {
  const Gasolineras({super.key, required this.state});

  final GasStationsState state;

  @override
  ConsumerState<Gasolineras> createState() => _GasolinerasState();
}

class _GasolinerasState extends ConsumerState<Gasolineras> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    _searchController.addListener(() {
      ref.read(gasStationsSearchQueryProvider.notifier).state =
          _searchController.text;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = ref.watch(filteredGasStationsProvider);

    return Column(
      children: [
        SearchField(searchController: _searchController, ref: ref),
        GasStationsList(filtered: filtered),
      ],
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required TextEditingController searchController,
    required this.ref,
  }) : _searchController = searchController;

  final TextEditingController _searchController;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SearchAnchor(
        builder: (context, controller) {
          return SearchBar(
            controller: _searchController,
            padding: const WidgetStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0),
            ),
            onChanged: (value) {
              ref.read(gasStationsSearchQueryProvider.notifier).state = value;
            },
            leading: const Icon(Icons.search),
          );
        },
        suggestionsBuilder: (_, __) => [],
      ),
    );
  }
}

class GasStationsList extends StatelessWidget {
  const GasStationsList({super.key, required this.filtered});

  final List<GasStation> filtered;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (_, index) {
          final gasStation = filtered[index];
          return GasStationItem(gasStation: gasStation);
        },
      ),
    );
  }
}

class Error extends ConsumerWidget {
  const Error({super.key, required this.state});

  final GasStationsState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: kToolbarHeight),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state.errorMessage ?? 'Ha ocurrido un error'),
            AppVerticalSpacing.s16,
            ElevatedButton(
              onPressed: () =>
                  ref.read(gasStationsNotifierProvider.notifier).loadNearby(),
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}
