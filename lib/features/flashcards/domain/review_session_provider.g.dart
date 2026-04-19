// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_session_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reviewSessionHash() => r'fefc6ac9b83c7b12b15c1e6c1fa20e07c958280d';

/// Represents the session queue for the day
///
/// Copied from [reviewSession].
@ProviderFor(reviewSession)
final reviewSessionProvider = AutoDisposeFutureProvider<List<GreWord>>.internal(
  reviewSession,
  name: r'reviewSessionProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$reviewSessionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ReviewSessionRef = AutoDisposeFutureProviderRef<List<GreWord>>;
String _$wordProgressRepositoryHash() =>
    r'77e72e0c386a779d56676bfa2c848edfcc2495e7';

/// See also [WordProgressRepository].
@ProviderFor(WordProgressRepository)
final wordProgressRepositoryProvider = AutoDisposeAsyncNotifierProvider<
  WordProgressRepository,
  Map<String, WordProgress>
>.internal(
  WordProgressRepository.new,
  name: r'wordProgressRepositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$wordProgressRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WordProgressRepository =
    AutoDisposeAsyncNotifier<Map<String, WordProgress>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
