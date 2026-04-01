// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gas_stations_detail_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gasStationDetailNotifierHash() =>
    r'acb97506ad7626ffb369645bf0e1efe3af51ec31';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$GasStationDetailNotifier
    extends BuildlessAutoDisposeNotifier<GasStationsDetailState> {
  late final String id;

  GasStationsDetailState build(String id);
}

/// See also [GasStationDetailNotifier].
@ProviderFor(GasStationDetailNotifier)
const gasStationDetailNotifierProvider = GasStationDetailNotifierFamily();

/// See also [GasStationDetailNotifier].
class GasStationDetailNotifierFamily extends Family<GasStationsDetailState> {
  /// See also [GasStationDetailNotifier].
  const GasStationDetailNotifierFamily();

  /// See also [GasStationDetailNotifier].
  GasStationDetailNotifierProvider call(String id) {
    return GasStationDetailNotifierProvider(id);
  }

  @override
  GasStationDetailNotifierProvider getProviderOverride(
    covariant GasStationDetailNotifierProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'gasStationDetailNotifierProvider';
}

/// See also [GasStationDetailNotifier].
class GasStationDetailNotifierProvider
    extends
        AutoDisposeNotifierProviderImpl<
          GasStationDetailNotifier,
          GasStationsDetailState
        > {
  /// See also [GasStationDetailNotifier].
  GasStationDetailNotifierProvider(String id)
    : this._internal(
        () => GasStationDetailNotifier()..id = id,
        from: gasStationDetailNotifierProvider,
        name: r'gasStationDetailNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$gasStationDetailNotifierHash,
        dependencies: GasStationDetailNotifierFamily._dependencies,
        allTransitiveDependencies:
            GasStationDetailNotifierFamily._allTransitiveDependencies,
        id: id,
      );

  GasStationDetailNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  GasStationsDetailState runNotifierBuild(
    covariant GasStationDetailNotifier notifier,
  ) {
    return notifier.build(id);
  }

  @override
  Override overrideWith(GasStationDetailNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: GasStationDetailNotifierProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<
    GasStationDetailNotifier,
    GasStationsDetailState
  >
  createElement() {
    return _GasStationDetailNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GasStationDetailNotifierProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GasStationDetailNotifierRef
    on AutoDisposeNotifierProviderRef<GasStationsDetailState> {
  /// The parameter `id` of this provider.
  String get id;
}

class _GasStationDetailNotifierProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          GasStationDetailNotifier,
          GasStationsDetailState
        >
    with GasStationDetailNotifierRef {
  _GasStationDetailNotifierProviderElement(super.provider);

  @override
  String get id => (origin as GasStationDetailNotifierProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
