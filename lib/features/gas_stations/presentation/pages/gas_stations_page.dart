import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_app/core/location/location_provider.dart';
import 'package:gas_app/core/utils/extensions/string.dart';
import 'package:gas_app/features/auth/presentation/notifiers/auth_notifier.dart';
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
        final location = await ref.read(locationProvider.future);

        ref
            .read(gasStationsNotifierProvider.notifier)
            .loadNearby(
              lat: location.latitude,
              lng: location.longitude,
              radius: 5,
            );
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
              onPressed: () {
                ref.read(authNotifierProvider.notifier).logout();
              },
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
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(12),
              color: Colors.blue.shade50,
            ),
            child: GasStationItem(gasStation: gasStation),
          );
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GasStationText(text: gasStation.name.capitalizeFirst),
              if (gasStation.address != null)
                GasStationText(text: gasStation.address!),
              GasStationText(
                text: '${gasStation.city} (${gasStation.province})',
              ),
              GasStationText(
                text: 'Gasolina 95: ${gasStation.prices.gasoline95}',
              ),
              GasStationText(text: 'Diesel: ${gasStation.prices.dieselA}'),
              GasStationText(text: 'AdBlue: ${gasStation.prices.adblue}'),
              GasStationText(text: 'Latitude: ${gasStation.location.latitude}'),
              GasStationText(
                text: 'Longitude: ${gasStation.location.longitude}',
              ),
            ],
          ),
        ),
        IconButton(
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
          icon: const Icon(Icons.route, size: 32),
          style: IconButton.styleFrom(backgroundColor: Colors.black12),
        ),
      ],
    );
  }
}

class GasStationText extends StatelessWidget {
  const GasStationText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(color: Colors.black));
  }
}

class Error extends StatelessWidget {
  const Error({super.key, required this.state});

  final GasStationsState state;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(state.errorMessage ?? 'Error'));
  }
}
