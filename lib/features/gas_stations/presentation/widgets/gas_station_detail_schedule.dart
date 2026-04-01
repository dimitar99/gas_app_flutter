import 'package:flutter/material.dart';
import 'package:gas_app/core/theme/app_colors.dart';
import 'package:gas_app/core/theme/app_spacing.dart';
import 'package:gas_app/core/theme/app_text_styles.dart';
import 'package:gas_app/features/auth/presentation/widgets/gas_app_label.dart';
import 'package:gas_app/l10n/app_localizations.dart';

class GasStationDetailSchedule extends StatelessWidget {
  final String? schedule;
  const GasStationDetailSchedule({super.key, this.schedule});

  @override
  Widget build(BuildContext context) {
    if (schedule == null) return const SizedBox.shrink();

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
            fieldType: FieldType.schedule,
            text: AppLocalizations.of(context)!.gas_station_schedule_title,
            iconColor: AppColors.textPrimary,
            textStyle: AppTextStyles.heading3,
          ),
          AppVerticalSpacing.s8,
          Text(schedule!.replaceAll('; ', '\n'), style: AppTextStyles.heading4),
        ],
      ),
    );
  }
}
