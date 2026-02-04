import 'package:flutter/material.dart';
import 'package:gas_app/core/theme/app_colors.dart';
import 'package:gas_app/core/theme/app_text_styles.dart';

class AppTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final TextInputType keyboardType;
  final bool? obscureText;
  final String? Function(String?)? validator;
  const AppTextFormField({
    super.key,
    required this.controller,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText,
    this.validator,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool? _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: AppTextStyles.heading3,
      obscureText: _obscureText ?? false,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: AppTextStyles.body,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textSecondary),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.error, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.error, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        errorStyle: AppTextStyles.caption.copyWith(color: AppColors.error),
        suffixIcon: _obscureText != null
            ? IconButton(
                icon: Icon(
                  _obscureText! ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () => setState(() => _obscureText = !_obscureText!),
              )
            : null,
      ),
    );
  }
}
