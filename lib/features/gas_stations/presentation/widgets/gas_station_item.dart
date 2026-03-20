import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_app/core/theme/app_colors.dart';
import 'package:gas_app/core/theme/app_spacing.dart';
import 'package:gas_app/core/theme/app_text_styles.dart';
import 'package:gas_app/core/utils/extensions/string.dart';
import 'package:gas_app/features/gas_stations/domain/entities/gas_station.dart';
import 'package:map_launcher/map_launcher.dart';

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
          Row(
            children: [
              Text(
                gasStation.name.capitalizeFirst,
                style: AppTextStyles.heading3,
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.primary,
                ),
                child: Row(
                  children: [
                    Transform.rotate(
                      angle: 0.5,
                      child: const Icon(
                        Icons.navigation_outlined,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                    AppHorizontalSpacing.s4,
                    Text(
                      '${gasStation.distance} km',
                      style: AppTextStyles.small.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
