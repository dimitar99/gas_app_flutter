import 'package:flutter/material.dart';
import 'package:gas_app/core/theme/app_colors.dart';
import 'package:gas_app/core/theme/app_spacing.dart';
import 'package:gas_app/core/theme/app_text_styles.dart';
import 'package:gas_app/features/auth/presentation/widgets/gas_app_label.dart';
import 'package:gas_app/l10n/app_localizations.dart';

class GasStationDetailAddress extends StatelessWidget {
  final String? address;
  final String? city;
  final String? province;
  const GasStationDetailAddress({
    super.key,
    this.address,
    this.city,
    this.province,
  });
  @override
  Widget build(BuildContext context) {
    if (address == null) return const SizedBox.shrink();
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
            fieldType: FieldType.address,
            text: AppLocalizations.of(context)!.gas_station_address_title,
            iconColor: AppColors.textPrimary,
            textStyle: AppTextStyles.heading3,
          ),
          AppVerticalSpacing.s8,
          Text('$address', style: AppTextStyles.heading4),
          if (city != null && province != null)
            Text('$city ($province)', style: AppTextStyles.heading4),
        ],
      ),
    );
  }
}
