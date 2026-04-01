import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gas_app/core/theme/app_colors.dart';
import 'package:gas_app/core/theme/app_spacing.dart';
import 'package:gas_app/core/theme/app_text_styles.dart';
import 'package:gas_app/features/auth/presentation/notifiers/auth_notifier.dart';
import 'package:gas_app/features/auth/presentation/state/auth_state.dart';
import 'package:gas_app/features/auth/presentation/widgets/fuel_logo.dart';
import 'package:gas_app/features/auth/presentation/widgets/login_form.dart';
import 'package:gas_app/features/auth/presentation/widgets/register_form.dart';
import 'package:gas_app/l10n/app_localizations.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authNotifierProvider, (previous, next) {
      if (next.status == AuthStateStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              next.errorType == AuthErrorType.invalidCredentials
                  ? AppLocalizations.of(context)!.auth_login_invalid_credentials
                  : AppLocalizations.of(context)!.common_error_message,
              style: AppTextStyles.heading4.copyWith(color: AppColors.white),
            ),
            backgroundColor: AppColors.error,
          ),
        );
      }
    });

    final screen = ref.watch(authNotifierProvider.select((s) => s.screen));

    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            margin: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: kToolbarHeight,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.textPrimary.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppVerticalSpacing.s24,
                  const FuelLogo(),
                  AppVerticalSpacing.s20,
                  Text(
                    AppLocalizations.of(context)!.common_app_title,
                    style: AppTextStyles.heading1,
                  ),
                  AppVerticalSpacing.s12,
                  Text(
                    screen == AuthScreen.login
                        ? AppLocalizations.of(context)!.auth_welcome_back
                        : AppLocalizations.of(
                            context,
                          )!.auth_create_account_title,
                    style: AppTextStyles.heading4,
                  ),
                  screen == AuthScreen.login
                      ? const LoginForm()
                      : const RegisterForm(),
                  TextButton(
                    onPressed: () =>
                        ref.read(authNotifierProvider.notifier).changeScreen(),
                    child: Text(
                      screen == AuthScreen.login
                          ? AppLocalizations.of(context)!.auth_no_account_link
                          : AppLocalizations.of(
                              context,
                            )!.auth_already_have_account_link,
                      style: AppTextStyles.smallBold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
