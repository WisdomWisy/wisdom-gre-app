// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lobby_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userLobbiesHash() => r'a40120e242a6a215344b8f91d23113b320cb4dd5';

/// See also [userLobbies].
@ProviderFor(userLobbies)
final userLobbiesProvider = AutoDisposeStreamProvider<List<Duel>>.internal(
  userLobbies,
  name: r'userLobbiesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userLobbiesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserLobbiesRef = AutoDisposeStreamProviderRef<List<Duel>>;
String _$lobbyControllerHash() => r'069e77249dd9c2ca3273dbbb07f0dc4820583795';

/// See also [LobbyController].
@ProviderFor(LobbyController)
final lobbyControllerProvider =
    AsyncNotifierProvider<LobbyController, Duel?>.internal(
      LobbyController.new,
      name: r'lobbyControllerProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$lobbyControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$LobbyController = AsyncNotifier<Duel?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
