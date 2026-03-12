import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gas_app/core/theme/app_spacing.dart';
import 'package:gas_app/core/ui/validators/form_validators.dart';
import 'package:gas_app/core/ui/widgets/app_text_form_field.dart';
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
                textInputAction: TextInputAction.done,
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
