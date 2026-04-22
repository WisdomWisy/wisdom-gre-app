// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_goal_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dailyGoalHash() => r'9fef8ef242cbc63252c736cf9b5cadf53b7da449';

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

/// See also [dailyGoal].
@ProviderFor(dailyGoal)
const dailyGoalProvider = DailyGoalFamily();

/// See also [dailyGoal].
class DailyGoalFamily extends Family<int> {
  /// See also [dailyGoal].
  const DailyGoalFamily();

  /// See also [dailyGoal].
  DailyGoalProvider call({required int totalWords}) {
    return DailyGoalProvider(totalWords: totalWords);
  }

  @override
  DailyGoalProvider getProviderOverride(covariant DailyGoalProvider provider) {
    return call(totalWords: provider.totalWords);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'dailyGoalProvider';
}

/// See also [dailyGoal].
class DailyGoalProvider extends AutoDisposeProvider<int> {
  /// See also [dailyGoal].
  DailyGoalProvider({required int totalWords})
    : this._internal(
        (ref) => dailyGoal(ref as DailyGoalRef, totalWords: totalWords),
        from: dailyGoalProvider,
        name: r'dailyGoalProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$dailyGoalHash,
        dependencies: DailyGoalFamily._dependencies,
        allTransitiveDependencies: DailyGoalFamily._allTransitiveDependencies,
        totalWords: totalWords,
      );

  DailyGoalProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.totalWords,
  }) : super.internal();

  final int totalWords;

  @override
  Override overrideWith(int Function(DailyGoalRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: DailyGoalProvider._internal(
        (ref) => create(ref as DailyGoalRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        totalWords: totalWords,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<int> createElement() {
    return _DailyGoalProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DailyGoalProvider && other.totalWords == totalWords;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, totalWords.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DailyGoalRef on AutoDisposeProviderRef<int> {
  /// The parameter `totalWords` of this provider.
  int get totalWords;
}

class _DailyGoalProviderElement extends AutoDisposeProviderElement<int>
    with DailyGoalRef {
  _DailyGoalProviderElement(super.provider);

  @override
  int get totalWords => (origin as DailyGoalProvider).totalWords;
}

String _$examDateHash() => r'8d6057af7d36d5b4ff94beb11fbec92f272a6ac8';

/// See also [ExamDate].
@ProviderFor(ExamDate)
final examDateProvider =
    AutoDisposeNotifierProvider<ExamDate, DateTime?>.internal(
      ExamDate.new,
      name: r'examDateProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product') ? null : _$examDateHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ExamDate = AutoDisposeNotifier<DateTime?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
