import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_app/core/theme/app_colors.dart';
import 'package:gas_app/core/theme/app_spacing.dart';
import 'package:gas_app/core/theme/app_text_styles.dart';
import 'package:gas_app/core/utils/extensions/string.dart';
import 'package:gas_app/features/auth/presentation/providers/auth_usecases_providers.dart';
import 'package:gas_app/features/gas_stations/domain/entities/gas_station.dart';
import 'package:gas_app/features/gas_stations/presentation/notifiers/gas_stations_notifier.dart';
import 'package:gas_app/features/gas_stations/presentation/providers/gas_stations_providers.dart';
import 'package:gas_app/features/gas_stations/presentation/state/gas_stations_state.dart';
import 'package:map_launcher/map_launcher.dart';

class GasStationsPage extends ConsumerStatefulWidget {
  const GasStationsPage({super.key});

  @override
  ConsumerState<GasStationsPage> createState() => _GasStationsPageState();
}

class _GasStationsPageState extends ConsumerState<GasStationsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      try {
        ref.read(gasStationsNotifierProvider.notifier).loadNearby();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al obtener las gasolineras'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(gasStationsNotifierProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gasolineras'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => ref.read(logoutUseCaseProvider).call(),
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

class GasStationItem extends StatelessWidget {
  final GasStation gasStation;
  const GasStationItem({super.key, required this.gasStation});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(gasStation.name.capitalizeFirst, style: AppTextStyles.heading3),
          if (gasStation.address != null)
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 16),
                AppHorizontalSpacing.s4,
                Text(gasStation.address!),
              ],
            ),
          AppVerticalSpacing.s4,
          Row(
            children: [
              const Icon(Icons.location_city_outlined, size: 16),
              AppHorizontalSpacing.s4,
              Text('${gasStation.city} (${gasStation.province})'),
            ],
          ),
          AppVerticalSpacing.s4,
          if (gasStation.schedule != null)
            Row(
              children: [
                const Icon(Icons.access_time_outlined, size: 16),
                AppHorizontalSpacing.s4,
                Flexible(
                  child: Text(gasStation.schedule!.replaceAll('; ', '\n')),
                ),
              ],
            ),
          //
          //
          //
          AppVerticalSpacing.s12,
          Divider(color: AppColors.textSecondary.withValues(alpha: 0.2)),
          AppVerticalSpacing.s12,

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Gasolina 95: ${gasStation.prices.gasoline95}'),
              Text('Gasolina 98: ${gasStation.prices.gasoline98}'),
              Text('Diesel: ${gasStation.prices.dieselA}'),
              Text('Diesel Premium: ${gasStation.prices.dieselB}'),
              Text('AdBlue: ${gasStation.prices.adblue}'),
              // Text('GPL: ${gasStation.prices.gpl}'),
              // Text('GNL: ${gasStation.prices.gnl}'),
              // Text('GNC: ${gasStation.prices.gnc}'),
            ],
          ),
          AppVerticalSpacing.s16,

          ElevatedButton(
            onPressed: () async {
              final availableMaps = await MapLauncher.installedMaps;

              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: availableMaps.map((map) {
                        return ListTile(
                          leading: SvgPicture.asset(
                            map.icon,
                            height: 24,
                            fit: BoxFit.fitHeight,
                          ),
                          title: Text(map.mapName),
                          onTap: () {
                            if (gasStation.location.hasCoordinates) {
                              map.showDirections(
                                destination: Coords(
                                  gasStation.location.latitude ?? 0.0,
                                  gasStation.location.longitude ?? 0.0,
                                ),
                                destinationTitle: gasStation.name,
                              );
                            }
                            Navigator.pop(context);
                          },
                        );
                      }).toList(),
                    ),
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.gps_fixed),
                AppHorizontalSpacing.s8,
                Text('Como llegar'),
              ],
            ),
          ),
        ],
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
