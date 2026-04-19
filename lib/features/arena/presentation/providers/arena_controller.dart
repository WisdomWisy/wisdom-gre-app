import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wisdom_gre_app/features/vocabulary/domain/providers/vocabulary_provider.dart';
import 'package:wisdom_gre_app/features/vocabulary/data/models/gre_word.dart';
import 'package:wisdom_gre_app/features/vocabulary/data/models/practice_questions.dart';
import 'package:wisdom_gre_app/features/flashcards/domain/review_session_provider.dart';
import 'arena_state.dart';

part 'arena_controller.g.dart';

@riverpod
class ArenaController extends _$ArenaController {
  Timer? _countdownTimer;

  @override
  ArenaState build() {
    ref.onDispose(() {
      _countdownTimer?.cancel();
    });
    return const ArenaState();
  }

  void setMode(ArenaMode mode, ArenaStyle style, int customCount, {bool includeTC = true, bool includeSE = true, List<GreWord>? specificWords}) {
    state = state.copyWith(
       mode: mode, 
       style: style, 
       customQuestionCount: customCount,
       includeTextCompletion: includeTC,
       includeSentenceEquivalence: includeSE,
    );
    loadQuestions(specificWords: specificWords);
  }

  Future<void> loadQuestions({List<GreWord>? specificWords}) async {
    _countdownTimer?.cancel();
    state = state.copyWith(
        isLoading: true,
        questions: [],
        currentIndex: 0,
        score: 0,
        streakMultiplier: 1,
        isFinished: false,
        userAnswers: {},
        isAnswerRevealed: false,
    );
    
    List<GreWord> wordsSource;
    if (specificWords != null && specificWords.isNotEmpty && state.mode == ArenaMode.dailyFocus) {
      wordsSource = specificWords;
    } else if (state.mode == ArenaMode.dailyFocus) {
      // Find words reviewed today directly from the state
      try {
        final progressMap = await ref.read(wordProgressRepositoryProvider.future);
        final allWords = ref.read(vocabularyProvider).valueOrNull ?? [];
        final now = DateTime.now();
        final todayMidnight = DateTime(now.year, now.month, now.day);
        
        wordsSource = allWords.where((w) {
          final prog = progressMap[w.originalInput];
          if (prog?.lastReviewDate != null) {
            final lrDate = DateTime(prog!.lastReviewDate!.year, prog.lastReviewDate!.month, prog.lastReviewDate!.day);
            return lrDate.isAtSameMomentAs(todayMidnight);
          }
          return false;
        }).toList();
        
        // Fallback to marathon if empty
        if (wordsSource.isEmpty) {
           wordsSource = allWords;
        }
      } catch (e) {
        wordsSource = ref.read(vocabularyProvider).valueOrNull ?? [];
      }
    } else {
      wordsSource = ref.read(vocabularyProvider).valueOrNull ?? [];
    }

    if (wordsSource.isEmpty) {
      state = state.copyWith(isLoading: false);
      return;
    }

    List<ArenaQuestion> extractedQuestions = [];
    for (var word in wordsSource) {
      final pq = word.practiceQuestions;
      if (pq == null) continue;
      
      if (state.includeTextCompletion) {
        if (pq.textCompletions?.oneBlank != null) {
          extractedQuestions.add(_buildTCQuestion(word, pq.textCompletions!.oneBlank!, QuestionType.textCompletionOne));
        }
        if (pq.textCompletions?.twoBlanks != null) {
          extractedQuestions.add(_buildTCQuestion(word, pq.textCompletions!.twoBlanks!, QuestionType.textCompletionTwo));
        }
        if (pq.textCompletions?.threeBlanks != null) {
          extractedQuestions.add(_buildTCQuestion(word, pq.textCompletions!.threeBlanks!, QuestionType.textCompletionThree));
        }
      }

      if (state.includeSentenceEquivalence && pq.sentenceEquivalence != null) {
        final se = pq.sentenceEquivalence!;
        final options = [...se.correctAnswers, ...se.distractors];
        options.shuffle();
        extractedQuestions.add(ArenaQuestion(
          word: word,
          type: QuestionType.sentenceEquivalence,
          questionText: se.questionText,
          options: [options],
          correctAnswers: se.correctAnswers,
        ));
      }
    }

    extractedQuestions.shuffle();
    if (extractedQuestions.length > state.customQuestionCount) {
      extractedQuestions = extractedQuestions.sublist(0, state.customQuestionCount);
    }
    
    int initialTime = state.style == ArenaStyle.timed ? extractedQuestions.length * 90 : 0;
    
    state = state.copyWith(
      questions: extractedQuestions,
      isLoading: false,
      remainingTimeSeconds: initialTime,
    );

    if (state.style == ArenaStyle.timed && extractedQuestions.isNotEmpty) {
      _startTimer();
    }
  }

  void _startTimer() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingTimeSeconds > 0) {
        state = state.copyWith(remainingTimeSeconds: state.remainingTimeSeconds - 1);
      } else {
        timer.cancel();
        forceEndGame();
      }
    });
  }

  void forceEndGame() {
    _countdownTimer?.cancel();
    state = state.copyWith(isFinished: true);
  }

  ArenaQuestion _buildTCQuestion(GreWord word, TextCompletionQuestion tcQuestion, QuestionType type) {
    List<List<String>> options = [];
    List<String> corrects = [];
    for (var b in tcQuestion.blanks) {
      final ops = [b.correctAnswer, ...b.distractors];
      ops.shuffle();
      options.add(ops);
      corrects.add(b.correctAnswer);
    }
    return ArenaQuestion(
      word: word,
      type: type,
      questionText: tcQuestion.questionText,
      options: options,
      correctAnswers: corrects,
    );
  }

  void submitAnswer(bool isCorrect, QuestionType type, Map<int, String> answersForQuestion) {
    final updatedMap = Map<int, Map<int, String>>.from(state.userAnswers);
    updatedMap[state.currentIndex] = answersForQuestion;

    if (isCorrect) {
      int points = 0;
      if (type == QuestionType.textCompletionOne) {
        points = 10;
      } else if (type == QuestionType.textCompletionTwo) {
        points = 20;
      } else if (type == QuestionType.textCompletionThree) {
        points = 30;
      } else if (type == QuestionType.sentenceEquivalence) {
        points = 30;
      }

      final addedScore = points * state.streakMultiplier;
      final newStreak = state.streakMultiplier < 5 ? state.streakMultiplier + 1 : 5; // Max 5x

      state = state.copyWith(
        score: state.score + addedScore,
        streakMultiplier: newStreak,
        userAnswers: updatedMap,
      );
    } else {
      state = state.copyWith(
        streakMultiplier: 1,
        userAnswers: updatedMap,
      );
    }

    if (state.style == ArenaStyle.learning) {
      state = state.copyWith(isAnswerRevealed: true);
    } else {
      _nextQuestion();
    }
  }

  void nextQuestionAction() {
    state = state.copyWith(isAnswerRevealed: false);
    _nextQuestion();
  }

  void _nextQuestion() {
    if (state.currentIndex + 1 >= state.questions.length) {
      _countdownTimer?.cancel();
      state = state.copyWith(isFinished: true);
    } else {
      state = state.copyWith(currentIndex: state.currentIndex + 1);
    }
  }
}
