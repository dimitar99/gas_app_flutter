enum ProfileStatus { initial, loading, success, editing, error }

class ProfileState {
  final ProfileStatus status;
  final String? initialFuel;
  final double? initialTankSize;
  final String? fuel;
  final double? tankSize;
  final double? radius;
  final bool navigateBack;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.initialFuel,
    this.initialTankSize,
    this.fuel,
    this.tankSize,
    this.radius,
    this.navigateBack = false,
  });

  factory ProfileState.initial() => const ProfileState();

  factory ProfileState.loading() =>
      const ProfileState(status: ProfileStatus.loading);

  factory ProfileState.error() =>
      const ProfileState(status: ProfileStatus.error);

  factory ProfileState.success(
    String fuel,
    double tankSize,
    double radius,
    bool navigateBack,
  ) => ProfileState(
    status: ProfileStatus.success,
    initialFuel: fuel,
    initialTankSize: tankSize,
    fuel: fuel,
    tankSize: tankSize,
    radius: radius,
    navigateBack: navigateBack,
  );

  ProfileState copyWith({
    ProfileStatus? status,
    String? initialFuel,
    double? initialTankSize,
    String? fuel,
    double? tankSize,
    double? radius,
  }) {
    return ProfileState(
      status: status ?? this.status,
      initialFuel: initialFuel ?? this.initialFuel,
      initialTankSize: initialTankSize ?? this.initialTankSize,
      fuel: fuel ?? this.fuel,
      tankSize: tankSize ?? this.tankSize,
      radius: radius ?? this.radius,
    );
  }
}
