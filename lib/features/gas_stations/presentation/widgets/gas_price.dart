import 'package:flutter/material.dart';
import 'package:gas_app/core/theme/app_colors.dart';
import 'package:gas_app/core/theme/app_text_styles.dart';
import 'package:gas_app/l10n/app_localizations.dart';

enum GasType {
  gasoline95,
  gasoline98,
  dieselA,
  dieselB,
  adblue,
  glp,
  gnc;

  String getTranslatedName(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      case GasType.gasoline95:
        return l10n.gas_station_gasoline_95;
      case GasType.gasoline98:
        return l10n.gas_station_gasoline_98;
      case GasType.dieselA:
        return l10n.gas_station_diesel_a;
      case GasType.dieselB:
        return l10n.gas_station_diesel_b;
      case GasType.adblue:
        return l10n.gas_station_adblue;
      case GasType.glp:
        return l10n.gas_station_glp;
      case GasType.gnc:
        return l10n.gas_station_gnc;
    }
  }
}

class GasPrice extends StatelessWidget {
  final GasType type;
  final double price;
  final bool userPrice;

  const GasPrice(this.type, this.price, {super.key, this.userPrice = false});

  Color colorByType() {
    switch (type) {
      case GasType.gasoline95:
        return AppColors.lightGreen;
      case GasType.gasoline98:
        return AppColors.success;
      case GasType.dieselA:
        return AppColors.darkGrey;
      case GasType.dieselB:
        return AppColors.textPrimary;
      case GasType.adblue:
        return AppColors.blue;
      case GasType.glp:
        return AppColors.lime;
      case GasType.gnc:
        return AppColors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: colorByType().withValues(alpha: 0.3),
        border: Border.all(
          color: userPrice ? colorByType() : Colors.transparent,
          width: userPrice ? 3 : 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '${type.getTranslatedName(context)}: $price€',
        style: AppTextStyles.heading4.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
