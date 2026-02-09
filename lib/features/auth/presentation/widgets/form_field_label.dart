import 'package:flutter/material.dart';
import 'package:gas_app/core/theme/app_colors.dart';
import 'package:gas_app/core/theme/app_spacing.dart';
import 'package:gas_app/core/theme/app_text_styles.dart';

enum FieldType { email, password, fuel, tank, radio }

class FormFieldLabel extends StatelessWidget {
  final FieldType fieldType;
  final String text;
  const FormFieldLabel({
    super.key,
    required this.fieldType,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        switch (fieldType) {
          FieldType.email => const Icon(Icons.email, color: AppColors.primary),
          FieldType.password => const Icon(
            Icons.lock,
            color: AppColors.primary,
          ),
          FieldType.fuel => const Icon(
            Icons.local_gas_station,
            color: AppColors.primary,
          ),
          FieldType.tank => const Icon(
            Icons.local_gas_station,
            color: AppColors.primary,
          ),
          FieldType.radio => const Icon(
            Icons.radio_button_checked,
            color: AppColors.primary,
          ),
        },
        AppHorizontalSpacing.s8,
        Text(text, style: AppTextStyles.heading3),
      ],
    );
  }
}
