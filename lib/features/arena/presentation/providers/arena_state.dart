import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wisdom_gre_app/features/vocabulary/data/models/gre_word.dart';

part 'arena_state.freezed.dart';

enum ArenaMode { dailyFocus, marathon }
enum ArenaStyle { learning, timed }
enum QuestionType { textCompletionOne, textCompletionTwo, textCompletionThree, sentenceEquivalence }

@freezed
abstract class ArenaQuestion with _$ArenaQuestion {
  const factory ArenaQuestion({
    required GreWord word,
    required QuestionType type,
    required String questionText,
    required List<List<String>> options, // List of options for each blank, or 1 list for SE
    required List<String> correctAnswers, // Correct answer for each blank, or 2 for SE
  }) = _ArenaQuestion;
}

@freezed
abstract class ArenaState with _$ArenaState {
  const factory ArenaState({
    @Default(ArenaMode.dailyFocus) ArenaMode mode,
    @Default(ArenaStyle.learning) ArenaStyle style,
    @Default(10) int customQuestionCount,
    @Default([]) List<ArenaQuestion> questions,
    @Default(0) int currentIndex,
    @Default(0) int score,
    @Default(1) int streakMultiplier,
    @Default(false) bool isFinished,
    @Default(false) bool isLoading,
    @Default({}) Map<int, Map<int, String>> userAnswers, // questionIndex -> blankIndex -> answer
    @Default(0) int remainingTimeSeconds,
    @Default(false) bool isAnswerRevealed, // specifically for learning mode
    @Default(true) bool includeTextCompletion,
    @Default(true) bool includeSentenceEquivalence,
  }) = _ArenaState;
}
