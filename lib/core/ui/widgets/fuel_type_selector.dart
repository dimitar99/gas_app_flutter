import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gas_app/core/theme/app_colors.dart';
import 'package:gas_app/core/theme/app_spacing.dart';
import 'package:gas_app/core/theme/app_text_styles.dart';
import 'package:gas_app/features/auth/presentation/widgets/gas_app_label.dart';
import 'package:gas_app/l10n/app_localizations.dart';

class FuelTypeSelector extends ConsumerWidget {
  final String initialValue;
  final void Function(String?)? onChanged;
  final bool enabled;
  const FuelTypeSelector({
    super.key,
    required this.initialValue,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        GasAppLabel(
          fieldType: FieldType.fuel,
          text: AppLocalizations.of(context)!.preferred_fuel_type_label,
        ),
        AppVerticalSpacing.s8,
        IgnorePointer(
          ignoring: !enabled,
          child: DropdownButtonFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.textSecondary),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.textSecondary,
                  width: 1,
                ),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
            icon: const Icon(
              Icons.arrow_drop_down,
              color: AppColors.textSecondary,
            ),
            hint: Text(
              AppLocalizations.of(context)!.select_fuel_hint,
              style: AppTextStyles.small,
            ),
            style: AppTextStyles.heading4.copyWith(
              color: enabled ? AppColors.textPrimary : AppColors.textSecondary,
            ),
            dropdownColor: AppColors.white,
            items: [
              DropdownMenuItem(
                value: 'gasoline95',
                child: Text(
                  AppLocalizations.of(context)!.gas_station_gasoline_95,
                ),
              ),
              DropdownMenuItem(
                value: 'gasoline98',
                child: Text(
                  AppLocalizations.of(context)!.gas_station_gasoline_98,
                ),
              ),
              DropdownMenuItem(
                value: 'dieselA',
                child: Text(AppLocalizations.of(context)!.gas_station_diesel_a),
              ),
              DropdownMenuItem(
                value: 'dieselB',
                child: Text(AppLocalizations.of(context)!.gas_station_diesel_b),
              ),
              DropdownMenuItem(
                value: 'glp',
                child: Text(AppLocalizations.of(context)!.gas_station_glp),
              ),
              DropdownMenuItem(
                value: 'gnc',
                child: Text(AppLocalizations.of(context)!.gas_station_gnc),
              ),
            ],
            initialValue: initialValue,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
