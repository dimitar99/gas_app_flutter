import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gas_app/core/router/routes.dart';
import 'package:gas_app/core/theme/app_spacing.dart';
import 'package:gas_app/core/theme/app_text_styles.dart';
import 'package:gas_app/features/auth/presentation/notifiers/auth_notifier.dart';
import 'package:gas_app/features/auth/presentation/state/auth_state.dart';
import 'package:gas_app/features/auth/presentation/widgets/fuel_logo.dart';
import 'package:gas_app/features/auth/presentation/widgets/login_form.dart';
import 'package:gas_app/features/auth/presentation/widgets/register_form.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authNotifierProvider, (previous, next) {
      if (next.status == AuthStateStatus.authenticated) {
        context.go(AppRoutes.gasStations);
      } else if (next.status == AuthStateStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              next.errorType == AuthErrorType.invalidCredentials
                  ? 'Credenciales inválidas'
                  : 'Ha ocurrido un error',
            ),
            backgroundColor: Colors.redAccent,
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
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
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
                  const Text('Gas App', style: AppTextStyles.heading1),
                  AppVerticalSpacing.s12,
                  Text(
                    screen == AuthScreen.login
                        ? 'Bienvenido de nuevo'
                        : 'Crear una cuenta nueva',
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
                          ? '¿No tienes cuenta? Regístrate'
                          : '¿Ya tienes cuenta? Inicia sesión',
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
