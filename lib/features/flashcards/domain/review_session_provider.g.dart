// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_session_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reviewSessionHash() => r'd384fb7fd05b712942578b8e4ce563c4fbdf0565';

/// Represents the active session queue for the day (excluding already reviewed)
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
String _$dailyWordsListHash() => r'f07173b29ff8dad72b3fefe7a99b21a5aec43b95';

/// Represents the full daily list (including already reviewed)
///
/// Copied from [dailyWordsList].
@ProviderFor(dailyWordsList)
final dailyWordsListProvider =
    AutoDisposeFutureProvider<List<GreWord>>.internal(
      dailyWordsList,
      name: r'dailyWordsListProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$dailyWordsListHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DailyWordsListRef = AutoDisposeFutureProviderRef<List<GreWord>>;
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
String _$dailyQueueHash() => r'07a8e3dbccac8033640fffef577193768c41743c';

/// See also [DailyQueue].
@ProviderFor(DailyQueue)
final dailyQueueProvider =
    AutoDisposeAsyncNotifierProvider<DailyQueue, List<String>>.internal(
      DailyQueue.new,
      name: r'dailyQueueProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$dailyQueueHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$DailyQueue = AutoDisposeAsyncNotifier<List<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
