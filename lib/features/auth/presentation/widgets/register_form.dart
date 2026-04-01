import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gas_app/core/theme/app_spacing.dart';
import 'package:gas_app/core/theme/app_text_styles.dart';
import 'package:gas_app/core/ui/validators/form_validators.dart';
import 'package:gas_app/core/ui/widgets/app_text_form_field.dart';
import 'package:gas_app/core/ui/widgets/fuel_type_selector.dart';
import 'package:gas_app/core/ui/widgets/gas_app_selector.dart';
import 'package:gas_app/features/auth/presentation/notifiers/auth_notifier.dart';
import 'package:gas_app/features/auth/presentation/widgets/gas_app_label.dart';
import 'package:gas_app/features/auth/presentation/widgets/login_register_button.dart';
import 'package:gas_app/l10n/app_localizations.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
              _Email(emailController: _emailController),
              AppVerticalSpacing.s24,

              _Password(passwordController: _passwordController),
              AppVerticalSpacing.s24,

              const _OptionalText(),
              AppVerticalSpacing.s24,

              FuelTypeSelector(
                initialValue: ref.read(
                  authNotifierProvider.select((s) => s.selectedFuel),
                ),
                onChanged: (value) =>
                    ref.read(authNotifierProvider.notifier).setFuel(value!),
              ),
              AppVerticalSpacing.s24,

              GasAppSelector(
                type: SelectorType.tank,
                value: ref.watch(
                  authNotifierProvider.select((s) => s.tankSize),
                ),
                onChanged: (value) =>
                    ref.read(authNotifierProvider.notifier).setTankSize(value),
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

class _Email extends StatelessWidget {
  final TextEditingController emailController;
  const _Email({required this.emailController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GasAppLabel(
          fieldType: FieldType.email,
          text: AppLocalizations.of(context)!.email_label,
        ),
        AppVerticalSpacing.s8,
        AppTextFormField(
          controller: emailController,
          hintText: AppLocalizations.of(context)!.email_hint,
          validator: (value) => FormValidators.email(context, value),
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }
}

class _Password extends StatelessWidget {
  final TextEditingController passwordController;
  const _Password({required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GasAppLabel(
          fieldType: FieldType.password,
          text: AppLocalizations.of(context)!.password_label,
        ),
        AppVerticalSpacing.s8,
        AppTextFormField(
          controller: passwordController,
          hintText: AppLocalizations.of(context)!.password_hint,
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocalizations.of(context)!.validator_password_empty;
            }
            if (value.length < 6) {
              return AppLocalizations.of(context)!.validator_password_length;
            }
            return null;
          },
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}

class _OptionalText extends StatelessWidget {
  const _OptionalText();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            AppLocalizations.of(context)!.preferences_optional_label,
            style: AppTextStyles.body,
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}
