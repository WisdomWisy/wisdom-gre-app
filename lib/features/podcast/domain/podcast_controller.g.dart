// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$podcastControllerHash() => r'9c1f736c5f79fe1038da9ef9a898279aae61a911';

/// Podcast Mode Controller — TTS-only, using manual completion detection.
///
/// We do NOT use awaitSpeakCompletion(true) because its internal Completer
/// becomes corrupted after tts.stop() calls on Android, causing indefinite hangs.
/// Instead, we use setCompletionHandler + setErrorHandler + our own Completer
/// to reliably detect when each utterance finishes.
///
/// Copied from [PodcastController].
@ProviderFor(PodcastController)
final podcastControllerProvider =
    NotifierProvider<PodcastController, PodcastState>.internal(
      PodcastController.new,
      name: r'podcastControllerProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$podcastControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PodcastController = Notifier<PodcastState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
