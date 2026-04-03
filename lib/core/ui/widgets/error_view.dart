import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gas_app/core/theme/app_spacing.dart';
import 'package:gas_app/l10n/app_localizations.dart';

class ErrorView extends ConsumerWidget {
  final Function()? retry;
  const ErrorView({super.key, this.retry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: kToolbarHeight),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.common_error_message),
            if (retry != null) ...[
              AppVerticalSpacing.s16,
              ElevatedButton(
                onPressed: retry,
                child: Text(AppLocalizations.of(context)!.common_retry),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
