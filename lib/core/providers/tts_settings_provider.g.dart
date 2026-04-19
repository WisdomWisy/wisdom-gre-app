// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tts_settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ttsSpeechRateControllerHash() =>
    r'230c32c8d5302688b548b37f840c8048986133a5';

/// Persists the user's preferred TTS speech rate across sessions.
/// Range: 0.1 (very slow) – 1.0 (native speed).
/// Default: 0.5 (comfortable for language learning).
///
/// Copied from [TtsSpeechRateController].
@ProviderFor(TtsSpeechRateController)
final ttsSpeechRateControllerProvider =
    NotifierProvider<TtsSpeechRateController, double>.internal(
      TtsSpeechRateController.new,
      name: r'ttsSpeechRateControllerProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$ttsSpeechRateControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TtsSpeechRateController = Notifier<double>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
