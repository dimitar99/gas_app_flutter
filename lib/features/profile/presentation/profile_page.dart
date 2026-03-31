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

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
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
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  color: Colors.grey[300],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.settings, color: Colors.grey[600]),
                        AppHorizontalSpacing.s8,
                        const Text(
                          'Preferencias',
                          style: AppTextStyles.heading3,
                        ),
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
                      backgroundColor: WidgetStatePropertyAll(
                        AppColors.primary,
                      ),
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
                    icon: const Icon(Icons.cancel, color: Colors.white),
                    onPressed: () => toggleEditing(),
                  ),
                ),
            ],
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!),
                left: BorderSide(color: Colors.grey[300]!),
                right: BorderSide(color: Colors.grey[300]!),
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
                              fuel,
                              tankSize,
                              radius,
                            ),
                            style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                AppColors.primary,
                              ),
                            ),
                            child: Text(
                              'Actualizar',
                              style: AppTextStyles.heading4.copyWith(
                                color: Colors.white,
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
          ),
          AppVerticalSpacing.s12,

          SizedBox(
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
          ),
        ],
      ),
    );
  }
}
