// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_session_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reviewSessionHash() => r'4763d9e70a472225282febce4344651c3eb53ffa';

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
    r'ff279ac4298b38064be35760386a1213993cedf2';

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
