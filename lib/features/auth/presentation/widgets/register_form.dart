import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gas_app/core/theme/app_colors.dart';
import 'package:gas_app/core/theme/app_spacing.dart';
import 'package:gas_app/core/theme/app_text_styles.dart';
import 'package:gas_app/core/ui/validators/form_validators.dart';
import 'package:gas_app/core/ui/widgets/app_text_form_field.dart';
import 'package:gas_app/features/auth/presentation/notifiers/auth_notifier.dart';
import 'package:gas_app/features/auth/presentation/widgets/form_field_label.dart';
import 'package:gas_app/features/auth/presentation/widgets/login_register_button.dart';

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

              const _FuelType(),
              AppVerticalSpacing.s24,

              const _TankCapacitySlider(),
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
        const FormFieldLabel(
          fieldType: FieldType.email,
          text: 'Correo electrónico',
        ),
        AppVerticalSpacing.s8,
        AppTextFormField(
          controller: emailController,
          hintText: 'test@email.com',
          validator: FormValidators.email,
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
        const FormFieldLabel(fieldType: FieldType.password, text: 'Contraseña'),
        AppVerticalSpacing.s8,
        AppTextFormField(
          controller: passwordController,
          hintText: '********',
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, ingrese su contraseña';
            }
            if (value.length < 6) {
              return 'La contraseña debe tener al menos 6 caracteres';
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
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text('Preferencias (opcional)', style: AppTextStyles.body),
        ),
        Expanded(child: Divider()),
      ],
    );
  }
}

class _FuelType extends ConsumerWidget {
  const _FuelType();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const FormFieldLabel(
          fieldType: FieldType.fuel,
          text: 'Tipo de combustible preferido',
        ),
        AppVerticalSpacing.s8,
        DropdownButtonFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.textSecondary),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.textSecondary, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
          icon: const Icon(
            Icons.arrow_drop_down,
            color: AppColors.textSecondary,
          ),
          hint: const Text(
            'Seleccione un combustible',
            style: AppTextStyles.small,
          ),
          style: AppTextStyles.heading4,
          dropdownColor: AppColors.white,
          items: const [
            DropdownMenuItem(value: 'gasoline95', child: Text('Gasolina 95')),
            DropdownMenuItem(value: 'gasoline98', child: Text('Gasolina 98')),
            DropdownMenuItem(value: 'dieselA', child: Text('Diesel')),
            DropdownMenuItem(value: 'dieselB', child: Text('Diesel Premium')),
            DropdownMenuItem(value: 'glp', child: Text('GLP')),
            DropdownMenuItem(value: 'gnc', child: Text('GNC')),
          ],
          initialValue: ref.read(
            authNotifierProvider.select((s) => s.selectedFuel),
          ),
          onChanged: (value) =>
              ref.read(authNotifierProvider.notifier).setFuel(value!),
        ),
      ],
    );
  }
}

class _TankCapacitySlider extends ConsumerWidget {
  const _TankCapacitySlider();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tankSize = ref.watch(authNotifierProvider.select((s) => s.tankSize));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormFieldLabel(
          fieldType: FieldType.tank,
          text: 'Capacidad del depósito (litros)',
        ),
        AppVerticalSpacing.s16,
        Slider(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          value: tankSize,
          min: 10,
          max: 130,
          divisions: 24,
          thumbColor: AppColors.primary,
          activeColor: AppColors.primary,
          onChanged: (value) {
            ref.read(authNotifierProvider.notifier).setTankSize(value);
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 12),
          child: Text(
            '${tankSize.toStringAsFixed(0)} litros',
            style: AppTextStyles.heading4,
          ),
        ),
      ],
    );
  }
}
