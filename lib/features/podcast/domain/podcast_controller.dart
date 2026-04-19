import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter/foundation.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:wisdom_gre_app/core/providers/language_provider.dart';
import 'package:wisdom_gre_app/core/providers/tts_settings_provider.dart';
import 'package:wisdom_gre_app/features/vocabulary/domain/providers/vocabulary_provider.dart';
import 'package:wisdom_gre_app/features/flashcards/domain/review_session_provider.dart';
import 'package:wisdom_gre_app/features/podcast/data/models/podcast_state.dart';

part 'podcast_controller.g.dart';

@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(ForegroundTaskHandler());
}

class ForegroundTaskHandler extends TaskHandler {
  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {}
  @override
  void onRepeatEvent(DateTime timestamp) {}
  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {}
  @override
  void onNotificationButtonPressed(String id) {}
  @override
  void onNotificationPressed() => FlutterForegroundTask.launchApp();
}

@Riverpod(keepAlive: true)
class PodcastController extends _$PodcastController {
  final FlutterTts _tts = FlutterTts();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioPlayer _keepAlivePlayer = AudioPlayer(); // DAC Spooler
  int _loopSessionId = 0;

  @override
  PodcastState build() {
    _initAudio();
    ref.onDispose(() {
      _loopSessionId++;
      _tts.stop();
      _audioPlayer.dispose();
      _keepAlivePlayer.dispose();
      FlutterForegroundTask.stopService();
      WakelockPlus.disable();
    });
    return const PodcastState();
  }

  Future<void> _initAudio() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    
    // Foreground Service Init
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'podcast_channel',
        channelName: 'Podcast Sync',
        channelDescription: 'Keeps podcast active in background',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.nothing(),
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
    
    // Hardware Initialization (Expert Mode)
    await _tts.setSharedInstance(true);
    await _tts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.playback,
        [IosTextToSpeechAudioCategoryOptions.duckOthers],
        IosTextToSpeechAudioMode.spokenAudio,
    );
    await _tts.awaitSpeakCompletion(true);
  }

  // ──────────────────────────────────────────────────────────
  // PUBLIC API
  // ──────────────────────────────────────────────────────────

  Future<void> loadQueue(PodcastSourceMode mode) async {
    _cancelLoop();
    await _tts.stop();
    state = state.copyWith(
        isLoading: true, sourceMode: mode, isPlaying: false, currentIndex: 0);
    try {
      if (mode == PodcastSourceMode.reviewSession) {
        final q = await ref.read(reviewSessionProvider.future);
        state = state.copyWith(queue: q, isLoading: false);
      } else {
        final all = await ref.read(vocabularyProvider.future);
        final shuffled = List.of(all)..shuffle();
        state = state.copyWith(queue: shuffled, isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> switchSourceMode() async {
    final newMode = state.sourceMode == PodcastSourceMode.allWords
        ? PodcastSourceMode.reviewSession
        : PodcastSourceMode.allWords;
    await loadQueue(newMode);
    play();
  }

  Future<void> play() async {
    if (state.queue.isEmpty || state.isPlaying) return;
    state = state.copyWith(isPlaying: true);
    WakelockPlus.enable();
    
    // Bluetooth Hardware Lock:
    // Enforcing an active audio session prevents Bluetooth amplifiers 
    // from entering sleep mode between sentences.
    final session = await AudioSession.instance;
    await session.setActive(true);
    
    // Hardware DAC Spooler (First-Syllable Cutoff Fix):
    // We broadcast infinite silence in the background. The hardware DAC NEVER powers
    // down between words. When TTS speaks, it hits a fully active 100% open channel.
    try {
      await _keepAlivePlayer.setAudioSource(
        SilenceAudioSource(duration: const Duration(minutes: 5))
      );
      await _keepAlivePlayer.setLoopMode(LoopMode.all);
      _keepAlivePlayer.play();
    } catch (_) {}
    
    try {
      if (await FlutterForegroundTask.isRunningService == false) {
        await FlutterForegroundTask.startService(
          notificationTitle: 'GRE Podcast',
          notificationText: 'Learning in progress...',
          callback: startCallback,
        );
      }
    } catch (e) {
      debugPrint("ForegroundTask start error: $e");
    }
    
    _playbackLoop(_newSession());
  }

  Future<void> pause() async {
    _cancelLoop();
    await _tts.stop(); 
    await _audioPlayer.stop();
    await _keepAlivePlayer.stop();
    await FlutterForegroundTask.stopService();
    
    final session = await AudioSession.instance;
    await session.setActive(false);
    
    state = state.copyWith(isPlaying: false);
    WakelockPlus.disable();
  }

  Future<void> next() async {
    if (state.currentIndex >= state.queue.length - 1) return;
    final wasPlaying = state.isPlaying;
    _cancelLoop();
    await _tts.stop();
    await _audioPlayer.stop();
    await _keepAlivePlayer.stop();
    state = state.copyWith(currentIndex: state.currentIndex + 1);
    if (wasPlaying) {
      state = state.copyWith(isPlaying: true);
      _playbackLoop(_newSession());
    }
  }

  Future<void> previous() async {
    if (state.currentIndex <= 0) return;
    final wasPlaying = state.isPlaying;
    _cancelLoop();
    await _tts.stop();
    await _audioPlayer.stop();
    await _keepAlivePlayer.stop();
    state = state.copyWith(currentIndex: state.currentIndex - 1);
    if (wasPlaying) {
      state = state.copyWith(isPlaying: true);
      _playbackLoop(_newSession());
    }
  }

  // ──────────────────────────────────────────────────────────
  // INTERNAL HELPERS
  // ──────────────────────────────────────────────────────────

  int _newSession() {
    _loopSessionId++;
    return _loopSessionId;
  }

  void _cancelLoop() => _loopSessionId++;

  bool _isDead(int id) => id != _loopSessionId;

  // Removed _readLanguage, directly using riverpod provider in loop

  /// Safely executes TTS with a guaranteed completion timeout to prevent native engine freezes.
  Future<bool> _safeSpeak(int id, String text, String language, double rate) async {
    if (_isDead(id) || text.trim().isEmpty) return false;
    final safeText = text.length > 500 ? '${text.substring(0, 500)}.' : text;

    try {
      await _tts.setLanguage(language);
      await _tts.setSpeechRate(rate);

      final completer = Completer<void>();

      _tts.setCompletionHandler(() {
        if (!completer.isCompleted) completer.complete();
      });

      _tts.setErrorHandler((msg) {
        debugPrint("TTS Error: $msg");
        if (!completer.isCompleted) completer.complete();
      });

      await _tts.speak(safeText);

      // Absolute security timeout to guarantee the loop will never hang indefinitely
      await completer.future.timeout(
        const Duration(seconds: 15),
        onTimeout: () => null,
      );
    } catch (e) {
      debugPrint("Exception in _safeSpeak: $e");
    }

    return !_isDead(id);
  }

  Future<bool> _playMp3(int id, String localPath, String fallbackWord, double rate) async {
    if (_isDead(id)) return false;
    try {
      await _audioPlayer.setAsset(localPath.isNotEmpty ? localPath : 'audio/$fallbackWord.mp3');
      await _audioPlayer.play();
      await _audioPlayer.stop(); // Explicitly release hardware stream
      
      // Slight delay to yield Audio Focus cleanly to the Android TTS Engine
      await Future.delayed(const Duration(milliseconds: 500));
      return !_isDead(id);
    } catch (_) {
      // Fallback to native TTS if MP3 asset loading fails
      return await _safeSpeak(id, fallbackWord, 'en-US', rate);
    }
  }

  Future<bool> _gap(int id, Duration d) async {
    if (_isDead(id)) return false;
    await Future.delayed(d);
    return !_isDead(id);
  }

  // ──────────────────────────────────────────────────────────
  // THE LOOP
  // ──────────────────────────────────────────────────────────

  Future<void> _playbackLoop(int id) async {
    while (!_isDead(id) && state.currentIndex < state.queue.length) {
      final word = state.currentWord;
      if (word == null) break;

      final lang = ref.read(languageControllerProvider);
      final rate = ref.read(ttsSpeechRateControllerProvider);

      try {
        // ── 1. Word (MP3 / ElevenLabs) ───────────────────────
        state = state.copyWith(
            currentlySpeakingTitle: 'Word', currentlySpeakingText: word.word);
        if (word.audioFile.isNotEmpty) {
          if (!await _playMp3(id, word.audioFile, word.word, rate)) break;
        } else {
          if (!await _safeSpeak(id, word.word, 'en-US', rate)) break;
        }
        if (!await _gap(id, const Duration(seconds: 1))) break;

        // ── 2. Definition (English) ──────────────────────────
        state = state.copyWith(
            currentlySpeakingTitle: 'Definition',
            currentlySpeakingText: word.definitionEn);
        if (!await _safeSpeak(id, word.definitionEn, 'en-US', rate)) break;
        if (!await _gap(id, const Duration(seconds: 1))) break;

        // ── 3. Translation / Synonyms (target language) ──────
        final String langCode;
        final String translationText;
        final String mnemonicText;

        if (lang == AppLanguage.fr) {
          langCode = 'fr-FR';
          translationText = word.translations.fr;
          mnemonicText = word.mnemonics.fr;
        } else if (lang == AppLanguage.es) {
          langCode = 'es-ES';
          translationText = word.translations.es;
          mnemonicText = word.mnemonics.es.isNotEmpty
              ? word.mnemonics.es
              : word.mnemonics.en;
        } else {
          langCode = 'en-US';
          translationText = word.synonyms.isNotEmpty
              ? 'Also known as: ${word.synonyms.join(', ')}'
              : '';
          mnemonicText = word.mnemonics.en;
        }

        if (translationText.isNotEmpty) {
          state = state.copyWith(
              currentlySpeakingTitle:
                  lang == AppLanguage.en ? 'Synonyms' : 'Translation',
              currentlySpeakingText: translationText);
          if (!await _safeSpeak(id, translationText, langCode, rate)) break;
          if (!await _gap(id, const Duration(seconds: 1))) break;
        }

        // ── 4. Mnemonic ──────────────────────────────────────
        if (mnemonicText.isNotEmpty) {
          state = state.copyWith(
              currentlySpeakingTitle: 'Mnemonic',
              currentlySpeakingText: mnemonicText);
          if (!await _safeSpeak(id, mnemonicText, langCode, rate)) break;
        }

        if (!await _gap(id, const Duration(seconds: 2))) break;

        // ── Advance to next word ─────────────────────────────
        if (state.currentIndex < state.queue.length - 1) {
          state = state.copyWith(currentIndex: state.currentIndex + 1);
        } else {
          state = state.copyWith(isPlaying: false);
          WakelockPlus.disable();
          final session = await AudioSession.instance;
          await session.setActive(false);
          await _keepAlivePlayer.stop();
          await FlutterForegroundTask.stopService();
          break;
        }
      } catch (e) {
        debugPrint("Loop error in _playbackLoop: $e");
        await Future.delayed(const Duration(seconds: 1));
      }
    }
  }
}
