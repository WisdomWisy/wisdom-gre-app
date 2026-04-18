import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wisdom_gre_app/features/vocabulary/data/models/gre_word.dart';

part 'podcast_state.freezed.dart';

enum PodcastSourceMode {
  reviewSession,
  allWords,
}

@freezed
abstract class PodcastState with _$PodcastState {
  const factory PodcastState({
    @Default(PodcastSourceMode.reviewSession) PodcastSourceMode sourceMode,
    @Default([]) List<GreWord> queue,
    @Default(0) int currentIndex,
    @Default(false) bool isPlaying,
    @Default(false) bool isLoading,
    @Default('') String error,
    
    // The currently active visible text (synced with TTS)
    @Default('') String currentlySpeakingText,
    @Default('') String currentlySpeakingTitle,
  }) = _PodcastState;
}

extension PodcastStateX on PodcastState {
  GreWord? get currentWord {
    if (queue.isEmpty || currentIndex >= queue.length || currentIndex < 0) return null;
    return queue[currentIndex];
  }
}
