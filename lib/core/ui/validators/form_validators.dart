import 'package:flutter/material.dart';
import 'package:gas_app/l10n/app_localizations.dart';

class FormValidators {
  const FormValidators._();

  static String? required(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.validator_required;
    }
    return null;
  }

  static String? email(BuildContext context, String? value) {
    final l10n = AppLocalizations.of(context)!;
    if (value == null || value.trim().isEmpty) {
      return l10n.validator_email_empty;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return l10n.validator_email_invalid;
    }

    return null;
  }

  static String? password(BuildContext context, String? value) {
    final l10n = AppLocalizations.of(context)!;
    if (value == null || value.trim().isEmpty) {
      return l10n.validator_password_empty;
    }

    if (value.trim().length < 6) {
      return l10n.validator_password_length;
    }

    return null;
  }
}
