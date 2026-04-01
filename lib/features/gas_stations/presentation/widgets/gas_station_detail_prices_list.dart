import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gas_app/core/theme/app_colors.dart';
import 'package:gas_app/core/theme/app_spacing.dart';
import 'package:gas_app/core/theme/app_text_styles.dart';
import 'package:gas_app/features/auth/presentation/widgets/gas_app_label.dart';
import 'package:gas_app/features/gas_stations/domain/entities/prices.dart';
import 'package:gas_app/features/gas_stations/presentation/widgets/gas_price.dart';
import 'package:gas_app/l10n/app_localizations.dart';

class GasStationDetailPricesList extends ConsumerWidget {
  final Prices prices;
  final String? userFuel;
  const GasStationDetailPricesList({
    super.key,
    required this.prices,
    required this.userFuel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availablePrices = [
      (GasType.gasoline95, prices.gasoline95),
      (GasType.gasoline98, prices.gasoline98),
      (GasType.dieselA, prices.dieselA),
      (GasType.dieselB, prices.dieselB),
      (GasType.adblue, prices.adblue),
      (GasType.glp, prices.glp),
      (GasType.gnc, prices.gnc),
    ].where((item) => item.$2 != null && item.$2! > 0).toList();

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GasAppLabel(
            fieldType: FieldType.prices,
            text: AppLocalizations.of(context)!.gas_station_prices_title,
            iconColor: AppColors.textPrimary,
            textStyle: AppTextStyles.heading3,
          ),
          AppVerticalSpacing.s12,
          for (int i = 0; i < availablePrices.length; i++) ...[
            GasDetailPrice(
              availablePrices[i].$1,
              availablePrices[i].$2!,
              userPrice:
                  userFuel == availablePrices[i].$1.toString().split('.').last,
            ),
            AppVerticalSpacing.s8,
            if (i < availablePrices.length - 1) const Divider(),
            AppVerticalSpacing.s8,
          ],
        ],
      ),
    );
  }
}
