import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gas_app/core/theme/app_colors.dart';
import 'package:gas_app/core/theme/app_spacing.dart';
import 'package:gas_app/core/theme/app_text_styles.dart';
import 'package:gas_app/features/auth/presentation/widgets/form_field_label.dart';

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
        const FormFieldLabel(
          fieldType: FieldType.fuel,
          text: 'Tipo de combustible preferido',
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
            hint: const Text(
              'Seleccione un combustible',
              style: AppTextStyles.small,
            ),
            style: AppTextStyles.heading4.copyWith(
              color: enabled ? AppColors.textPrimary : AppColors.textSecondary,
            ),
            dropdownColor: AppColors.white,
            items: const [
              DropdownMenuItem(value: 'gasoline95', child: Text('Gasolina 95')),
              DropdownMenuItem(value: 'gasoline98', child: Text('Gasolina 98')),
              DropdownMenuItem(value: 'dieselA', child: Text('Diesel')),
              DropdownMenuItem(value: 'dieselB', child: Text('Diesel Premium')),
              DropdownMenuItem(value: 'glp', child: Text('GLP')),
              DropdownMenuItem(value: 'gnc', child: Text('GNC')),
            ],
            initialValue: initialValue,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
