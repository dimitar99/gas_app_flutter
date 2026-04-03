import 'package:flutter/material.dart';

import 'package:gas_app/core/theme/app_colors.dart';
import 'package:gas_app/core/theme/app_spacing.dart';
import 'package:gas_app/core/theme/app_text_styles.dart';
import 'package:gas_app/features/gas_stations/domain/entities/gas_station.dart';
import 'package:gas_app/features/gas_stations/presentation/widgets/gas_price.dart';
import 'package:gas_app/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class GasStationItem extends StatelessWidget {
  final GasStation gasStation;
  final bool firstItem;
  const GasStationItem({
    super.key,
    required this.gasStation,
    this.firstItem = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/gas-stations-detail/${gasStation.id}'),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.textSecondary.withValues(alpha: 0.1),
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
                Text(gasStation.name, style: AppTextStyles.heading3),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
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
                          color: AppColors.white,
                        ),
                      ),
                      AppHorizontalSpacing.s4,
                      Text(
                        '${gasStation.distance} km',
                        style: AppTextStyles.small.copyWith(
                          color: AppColors.white,
                        ),
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
            AppVerticalSpacing.s12,

            if (gasStation.prices.gasoline95 != null) ...[
              GasPrice(
                GasType.gasoline95,
                gasStation.prices.gasoline95!,
                userPrice: true,
              ),
              AppVerticalSpacing.s12,
              if (firstItem)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.2),
                    border: Border.all(color: AppColors.success, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.gas_station_best_price,
                    style: AppTextStyles.smallBold.copyWith(
                      color: AppColors.success,
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
