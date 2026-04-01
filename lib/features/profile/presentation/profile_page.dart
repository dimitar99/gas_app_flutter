import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gas_app/core/theme/app_colors.dart';
import 'package:gas_app/core/theme/app_spacing.dart';
import 'package:gas_app/core/theme/app_text_styles.dart';
import 'package:gas_app/core/ui/widgets/fuel_type_selector.dart';
import 'package:gas_app/core/ui/widgets/gas_app_selector.dart';
import 'package:gas_app/features/auth/presentation/notifiers/auth_notifier.dart';
import 'package:gas_app/features/profile/presentation/notifiers/profile_notifier.dart';
import 'package:gas_app/features/profile/presentation/state/profile_state.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileNotifierProvider);

    ref.listen(profileNotifierProvider, (previous, next) {
      if (next.status == ProfileStatus.success && next.navigateBack) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Preferencias actualizadas',
              style: AppTextStyles.heading4.copyWith(color: AppColors.white),
            ),
            backgroundColor: AppColors.success,
          ),
        );
        context.pop();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: AppColors.white,
      ),
      backgroundColor: AppColors.white,
      body: switch (state.status) {
        ProfileStatus.initial || ProfileStatus.loading => Container(),
        ProfileStatus.editing || ProfileStatus.success => _Preferences(state),
        ProfileStatus.error => Center(
          child: Container(
            margin: const EdgeInsets.only(bottom: kToolbarHeight),
            child: const Text('Ha ocurrido un error'),
          ),
        ),
      },
    );
  }
}

class _Preferences extends ConsumerWidget {
  final ProfileState state;
  const _Preferences(this.state);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditing = ref.watch(profileNotifierProvider.notifier).isEditing();
    final toggleEditing = ref
        .read(profileNotifierProvider.notifier)
        .toggleEditing;

    final fuel = ref.read(profileNotifierProvider).fuel;
    final tankSize = ref.watch(profileNotifierProvider).tankSize;
    final radius = ref.watch(profileNotifierProvider).radius;

    final profileNotifier = ref.read(profileNotifierProvider.notifier);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _PreferencesHeader(
            isEditing: isEditing,
            toggleEditing: toggleEditing,
          ),

          _PrefencesContent(
            isEditing: isEditing,
            fuel: fuel,
            profileNotifier: profileNotifier,
            tankSize: tankSize,
            radius: radius,
          ),
          AppVerticalSpacing.s12,

          const _CloseSessionButton(),
        ],
      ),
    );
  }
}

class _PreferencesHeader extends StatelessWidget {
  final bool isEditing;
  final void Function() toggleEditing;
  const _PreferencesHeader({
    required this.isEditing,
    required this.toggleEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            color: AppColors.lightGrey,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.settings, color: AppColors.darkGrey),
                  AppHorizontalSpacing.s8,
                  Text('Preferencias', style: AppTextStyles.heading3),
                ],
              ),
            ],
          ),
        ),
        if (!isEditing) ...[
          Positioned(
            top: 6,
            right: 16,
            child: IconButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColors.primary),
              ),
              icon: const Icon(Icons.edit, color: Colors.white),
              onPressed: () => toggleEditing(),
            ),
          ),
        ] else
          Positioned(
            top: 6,
            right: 16,
            child: IconButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColors.error),
              ),
              icon: const Icon(Icons.cancel, color: AppColors.white),
              onPressed: () => toggleEditing(),
            ),
          ),
      ],
    );
  }
}

class _PrefencesContent extends StatelessWidget {
  final bool isEditing;
  final String? fuel;
  final ProfileNotifier profileNotifier;
  final double? tankSize;
  final double? radius;
  const _PrefencesContent({
    required this.isEditing,
    required this.fuel,
    required this.profileNotifier,
    required this.tankSize,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        border: Border(
          bottom: BorderSide(color: AppColors.lightGrey),
          left: BorderSide(color: AppColors.lightGrey),
          right: BorderSide(color: AppColors.lightGrey),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppVerticalSpacing.s12,
          FuelTypeSelector(
            enabled: isEditing,
            initialValue: fuel!,
            onChanged: (value) => profileNotifier.updateFuel(value!),
          ),
          AppVerticalSpacing.s24,

          GasAppSelector(
            type: SelectorType.tank,
            enabled: isEditing,
            value: tankSize!,
            onChanged: (value) => profileNotifier.updateTankSize(value),
          ),
          AppVerticalSpacing.s24,

          GasAppSelector(
            type: SelectorType.radio,
            enabled: isEditing,
            value: radius!,
            onChanged: (value) => profileNotifier.updateRadio(value),
          ),
          AppVerticalSpacing.s24,

          if (isEditing)
            Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    child: ElevatedButton(
                      onPressed: () => profileNotifier.updatePreferences(
                        fuel!,
                        tankSize!,
                        radius!,
                      ),
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          AppColors.primary,
                        ),
                      ),
                      child: Text(
                        'Actualizar',
                        style: AppTextStyles.heading4.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                AppVerticalSpacing.s24,
              ],
            ),
        ],
      ),
    );
  }
}

class _CloseSessionButton extends ConsumerWidget {
  const _CloseSessionButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.8,
      child: ElevatedButton(
        onPressed: () => ref.read(authNotifierProvider.notifier).logout(),
        style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(AppColors.error),
        ),
        child: Text(
          'Cerrar sesión',
          style: AppTextStyles.heading4.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
