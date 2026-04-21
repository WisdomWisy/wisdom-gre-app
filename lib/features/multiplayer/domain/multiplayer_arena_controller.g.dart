// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multiplayer_arena_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$multiplayerArenaControllerHash() =>
    r'86047ef86153ed7990e314b01fcb76a0ef8eaf73';

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

abstract class _$MultiplayerArenaController
    extends BuildlessNotifier<ArenaState> {
  late final String duelId;

  ArenaState build(String duelId);
}

/// See also [MultiplayerArenaController].
@ProviderFor(MultiplayerArenaController)
const multiplayerArenaControllerProvider = MultiplayerArenaControllerFamily();

/// See also [MultiplayerArenaController].
class MultiplayerArenaControllerFamily extends Family<ArenaState> {
  /// See also [MultiplayerArenaController].
  const MultiplayerArenaControllerFamily();

  /// See also [MultiplayerArenaController].
  MultiplayerArenaControllerProvider call(String duelId) {
    return MultiplayerArenaControllerProvider(duelId);
  }

  @override
  MultiplayerArenaControllerProvider getProviderOverride(
    covariant MultiplayerArenaControllerProvider provider,
  ) {
    return call(provider.duelId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'multiplayerArenaControllerProvider';
}

/// See also [MultiplayerArenaController].
class MultiplayerArenaControllerProvider
    extends NotifierProviderImpl<MultiplayerArenaController, ArenaState> {
  /// See also [MultiplayerArenaController].
  MultiplayerArenaControllerProvider(String duelId)
    : this._internal(
        () => MultiplayerArenaController()..duelId = duelId,
        from: multiplayerArenaControllerProvider,
        name: r'multiplayerArenaControllerProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$multiplayerArenaControllerHash,
        dependencies: MultiplayerArenaControllerFamily._dependencies,
        allTransitiveDependencies:
            MultiplayerArenaControllerFamily._allTransitiveDependencies,
        duelId: duelId,
      );

  MultiplayerArenaControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.duelId,
  }) : super.internal();

  final String duelId;

  @override
  ArenaState runNotifierBuild(covariant MultiplayerArenaController notifier) {
    return notifier.build(duelId);
  }

  @override
  Override overrideWith(MultiplayerArenaController Function() create) {
    return ProviderOverride(
      origin: this,
      override: MultiplayerArenaControllerProvider._internal(
        () => create()..duelId = duelId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        duelId: duelId,
      ),
    );
  }

  @override
  NotifierProviderElement<MultiplayerArenaController, ArenaState>
  createElement() {
    return _MultiplayerArenaControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MultiplayerArenaControllerProvider &&
        other.duelId == duelId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, duelId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MultiplayerArenaControllerRef on NotifierProviderRef<ArenaState> {
  /// The parameter `duelId` of this provider.
  String get duelId;
}

class _MultiplayerArenaControllerProviderElement
    extends NotifierProviderElement<MultiplayerArenaController, ArenaState>
    with MultiplayerArenaControllerRef {
  _MultiplayerArenaControllerProviderElement(super.provider);

  @override
  String get duelId => (origin as MultiplayerArenaControllerProvider).duelId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
