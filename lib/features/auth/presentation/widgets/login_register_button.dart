import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gas_app/core/theme/app_colors.dart';
import 'package:gas_app/core/theme/app_text_styles.dart';
import 'package:gas_app/features/auth/presentation/notifiers/auth_notifier.dart';
import 'package:gas_app/features/auth/presentation/state/auth_state.dart';
import 'package:gas_app/l10n/app_localizations.dart';

class LoginRegisterButton extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const LoginRegisterButton({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(authNotifierProvider.select((s) => s.status));
    final screen = ref.watch(authNotifierProvider.select((s) => s.screen));

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState?.validate() ?? false) {
            if (screen == AuthScreen.login) {
              ref
                  .read(authNotifierProvider.notifier)
                  .login(
                    email: emailController.text,
                    password: passwordController.text,
                  );
            } else {
              ref
                  .read(authNotifierProvider.notifier)
                  .register(
                    email: emailController.text,
                    password: passwordController.text,
                    fuel: ref.read(
                      authNotifierProvider.select((s) => s.selectedFuel),
                    ),
                    tankSize: ref.read(
                      authNotifierProvider.select((s) => s.tankSize),
                    ),
                  );
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: status == AuthStateStatus.loading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                      strokeWidth: 2,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    AppLocalizations.of(context)!.auth_button_processing,
                    style: AppTextStyles.smallBold.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ],
              )
            : Text(
                screen == AuthScreen.login
                    ? AppLocalizations.of(context)!.auth_button_login
                    : AppLocalizations.of(context)!.auth_button_register,
                style: AppTextStyles.smallBold.copyWith(color: AppColors.white),
              ),
      ),
    );
  }
}
