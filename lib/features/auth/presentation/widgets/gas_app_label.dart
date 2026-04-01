import 'package:flutter/material.dart';
import 'package:gas_app/core/theme/app_colors.dart';
import 'package:gas_app/core/theme/app_spacing.dart';
import 'package:gas_app/core/theme/app_text_styles.dart';

enum FieldType { email, password, fuel, tank, radio, address, prices, schedule }

class GasAppLabel extends StatelessWidget {
  final FieldType fieldType;
  final String text;
  final TextStyle textStyle;
  final Color iconColor;
  const GasAppLabel({
    super.key,
    required this.fieldType,
    required this.text,
    this.textStyle = AppTextStyles.heading4,
    this.iconColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        switch (fieldType) {
          FieldType.email => Icon(Icons.email, color: iconColor),
          FieldType.password => Icon(Icons.lock, color: iconColor),
          FieldType.fuel => Icon(Icons.local_gas_station, color: iconColor),
          FieldType.tank => Icon(Icons.local_gas_station, color: iconColor),
          FieldType.radio => Icon(Icons.radio_button_checked, color: iconColor),
          FieldType.address => Icon(Icons.home, color: iconColor),
          FieldType.prices => Icon(Icons.local_gas_station, color: iconColor),
          FieldType.schedule => Icon(Icons.schedule, color: iconColor),
        },
        AppHorizontalSpacing.s8,
        Text(text, style: textStyle),
      ],
    );
  }
}
