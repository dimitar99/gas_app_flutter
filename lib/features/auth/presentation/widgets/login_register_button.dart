import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gas_app/core/theme/app_colors.dart';
import 'package:gas_app/features/auth/presentation/notifiers/auth_notifier.dart';
import 'package:gas_app/features/auth/presentation/state/auth_state.dart';

class LoginRegisterButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final WidgetRef ref;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const LoginRegisterButton({
    super.key,
    required this.formKey,
    required this.ref,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(authNotifierProvider.select((s) => s.status));
    final screen = ref.watch(authNotifierProvider.select((s) => s.screen));

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState?.validate() ?? false) {
            ref
                .read(authNotifierProvider.notifier)
                .login(emailController.text, passwordController.text);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: status == AuthStateStatus.loading
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text('Procesando...', style: TextStyle(color: Colors.white)),
                ],
              )
            : Text(
                screen == AuthScreen.login ? 'Iniciar sesión' : 'Registrarse',
                style: const TextStyle(color: Colors.white),
              ),
      ),
    );
  }
}
