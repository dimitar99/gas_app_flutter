import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gas_app/core/theme/app_colors.dart';
import 'package:gas_app/core/theme/app_spacing.dart';
import 'package:gas_app/core/theme/app_text_styles.dart';
import 'package:gas_app/features/auth/presentation/widgets/gas_app_label.dart';

enum SelectorType { tank, radio }

class GasAppSelector extends ConsumerWidget {
  final SelectorType type;
  final double value;
  final void Function(double)? onChanged;
  final bool enabled;
  const GasAppSelector({
    super.key,
    required this.type,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GasAppLabel(
          fieldType: type == SelectorType.tank
              ? FieldType.tank
              : FieldType.radio,
          text: type == SelectorType.tank
              ? 'Capacidad del depósito (litros)'
              : 'Radio de búsqueda (km)',
        ),
        AppVerticalSpacing.s16,
        IgnorePointer(
          ignoring: !enabled,
          child: Slider(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            value: value,
            min: type == SelectorType.tank ? 10 : 5,
            max: type == SelectorType.tank ? 130 : 100,
            divisions: type == SelectorType.tank ? 24 : 19,
            thumbColor: enabled ? AppColors.primary : AppColors.textSecondary,
            activeColor: enabled ? AppColors.primary : AppColors.textSecondary,
            onChanged: onChanged,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 12),
          child: Text(
            '${value.toStringAsFixed(0)} ${type == SelectorType.tank ? 'litros' : 'km'}',
            style: AppTextStyles.heading4.copyWith(
              color: enabled ? AppColors.textPrimary : AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
