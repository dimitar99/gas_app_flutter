import 'package:flutter/material.dart';
import 'package:gas_app/core/theme/app_colors.dart';

abstract class AppTextStyles {
  static const heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const heading3 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
  static const body = TextStyle(fontSize: 16, fontWeight: FontWeight.normal);

  static const small = TextStyle(fontSize: 14, fontWeight: FontWeight.normal);
  static const smallBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const caption = TextStyle(fontSize: 12, fontWeight: FontWeight.normal);
}
