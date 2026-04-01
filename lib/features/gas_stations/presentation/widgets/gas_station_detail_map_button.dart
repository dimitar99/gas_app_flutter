import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gas_app/core/theme/app_colors.dart';
import 'package:gas_app/core/theme/app_spacing.dart';
import 'package:gas_app/features/gas_stations/domain/entities/location.dart';
import 'package:map_launcher/map_launcher.dart';

class GasStationDetailMapButton extends StatelessWidget {
  final Location location;
  final String name;
  const GasStationDetailMapButton({
    super.key,
    required this.location,
    required this.name,
  });

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
                      if (location.hasCoordinates) {
                        map.showDirections(
                          destination: Coords(
                            location.latitude ?? 0.0,
                            location.longitude ?? 0.0,
                          ),
                          destinationTitle: name,
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.gps_fixed),
          AppHorizontalSpacing.s8,
          Text('Como llegar'),
        ],
      ),
    );
  }
}
