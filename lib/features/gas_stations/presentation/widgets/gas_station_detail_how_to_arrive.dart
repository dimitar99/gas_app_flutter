import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gas_app/core/theme/app_colors.dart';
import 'package:gas_app/core/theme/app_spacing.dart';
import 'package:gas_app/core/theme/app_text_styles.dart';
import 'package:gas_app/features/gas_stations/domain/entities/gas_station.dart';
import 'package:gas_app/l10n/app_localizations.dart';
import 'package:map_launcher/map_launcher.dart';

class GasStationDetailHowToArrive extends StatelessWidget {
  final GasStation gasStation;
  const GasStationDetailHowToArrive({super.key, required this.gasStation});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.gps_fixed),
          AppHorizontalSpacing.s8,
          Text(
            AppLocalizations.of(context)!.gas_station_how_to_arrive,
            style: AppTextStyles.small.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
