import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gas_app/core/theme/app_spacing.dart';
import 'package:gas_app/core/theme/app_text_styles.dart';
import 'package:gas_app/core/ui/validators/form_validators.dart';
import 'package:gas_app/core/ui/widgets/app_text_form_field.dart';
import 'package:gas_app/features/auth/presentation/notifiers/auth_notifier.dart';
import 'package:gas_app/features/auth/presentation/state/auth_state.dart';
import 'package:gas_app/features/auth/presentation/widgets/form_field_label.dart';
import 'package:gas_app/features/auth/presentation/widgets/login_register_button.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _emailController = TextEditingController(text: "dimitar@example.com");
  final _passwordController = TextEditingController(text: "password123");
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final errorType = ref.watch(
      authNotifierProvider.select((s) => s.errorType),
    );
    final showPasswordError = ref.watch(
      authNotifierProvider.select((s) => s.showPasswordError),
    );
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppVerticalSpacing.s32,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FormFieldLabel(
                fieldType: FieldType.email,
                text: 'Correo electrónico',
              ),
              AppVerticalSpacing.s8,
              AppTextFormField(
                controller: _emailController,
                hintText: 'test@email.com',
                validator: FormValidators.email,
              ),
              AppVerticalSpacing.s24,

              const FormFieldLabel(
                fieldType: FieldType.password,
                text: 'Contraseña',
              ),
              AppVerticalSpacing.s8,

              AppTextFormField(
                controller: _passwordController,
                hintText: '********',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese su contraseña';
                  }
                  return null;
                },
              ),

              if (showPasswordError)
                Column(
                  children: [
                    AppVerticalSpacing.s16,
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 8,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(
                            context,
                          ).colorScheme.error.withValues(alpha: 0.5),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                        color: Theme.of(
                          context,
                        ).colorScheme.error.withValues(alpha: 0.1),
                      ),
                      child: Text(
                        errorType == AuthErrorType.invalidCredentials
                            ? 'Contraseña incorrecta'
                            : 'Ha ocurrido un error',
                        style: AppTextStyles.small.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          AppVerticalSpacing.s16,
          LoginRegisterButton(
            formKey: _formKey,
            emailController: _emailController,
            passwordController: _passwordController,
          ),
        ],
      ),
    );
  }
}
