import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wisdom_gre_app/features/vocabulary/data/models/gre_word.dart';
import 'package:wisdom_gre_app/features/flashcards/domain/review_session_provider.dart';
import 'package:wisdom_gre_app/features/flashcards/domain/srs_helper.dart';
import 'package:wisdom_gre_app/features/flashcards/data/models/word_progress.dart';
import 'package:wisdom_gre_app/features/dashboard/domain/providers/exam_goal_provider.dart';
import 'package:wisdom_gre_app/features/vocabulary/domain/providers/vocabulary_provider.dart';

part 'flashcard_session_controller.freezed.dart';
part 'flashcard_session_controller.g.dart';

enum FlashcardSessionMode {
  srs,
  reviewAgain,
  anticipateTracked,
  anticipateGhost,
}

@freezed
abstract class FlashcardSessionState with _$FlashcardSessionState {
  const factory FlashcardSessionState({
    required List<GreWord> queue,
    required FlashcardSessionMode mode,
    required int initialQueueLength,
  }) = _FlashcardSessionState;
}

@riverpod
class FlashcardSessionController extends _$FlashcardSessionController {
  @override
  FutureOr<FlashcardSessionState> build() async {
    final srsQueue = await ref.watch(reviewSessionProvider.future);
    
    // Preserve local Ghost/Review mode state even if SRS provider invalidates
    if (state.hasValue && 
        (state.value!.mode == FlashcardSessionMode.reviewAgain || 
         state.value!.mode == FlashcardSessionMode.anticipateGhost)) {
      return state.value!;
    }
    
    return FlashcardSessionState(
      queue: List.from(srsQueue),
      mode: state.valueOrNull?.mode ?? FlashcardSessionMode.srs,
      initialQueueLength: state.valueOrNull?.initialQueueLength ?? srsQueue.length,
    );
  }

  Future<void> rateWord(ReviewGrade grade) async {
    final currentState = state.valueOrNull;
    if (currentState == null || currentState.queue.isEmpty) return;

    final word = currentState.queue.first;

    if (currentState.mode == FlashcardSessionMode.srs || currentState.mode == FlashcardSessionMode.anticipateTracked) {
      final progressMap = await ref.read(wordProgressRepositoryProvider.future);
      final currentProgress = progressMap[word.originalInput];
      final progress = currentProgress ?? WordProgress(wordId: word.originalInput, nextReviewDate: DateTime.now());
      
      final newProgress = SRSHelper.calculateNextReview(progress, grade);
      
      // Save progress (this will invalidate reviewSessionProvider and rebuild this controller)
      await ref.read(wordProgressRepositoryProvider.notifier).saveProgress(newProgress);
      return; // The rebuild will naturally pop the queue because reviewSessionProvider filters out studied words
    }

    // Ghost or Review mode: Just pop the queue locally without touching SRS!
    final newQueue = List<GreWord>.from(currentState.queue)..removeAt(0);
    state = AsyncData(currentState.copyWith(queue: newQueue));
  }

  Future<void> startReviewAgain() async {
    state = const AsyncLoading();
    final dailyList = await ref.read(dailyWordsListProvider.future);
    final listCopy = List<GreWord>.from(dailyList)..shuffle();
    state = AsyncData(FlashcardSessionState(
      queue: listCopy,
      mode: FlashcardSessionMode.reviewAgain,
      initialQueueLength: listCopy.length,
    ));
  }

  Future<void> startAnticipation(bool tracked) async {
    state = const AsyncLoading();
    final allWordsQuery = await ref.read(vocabularyProvider.future);
    final totalWords = allWordsQuery.length;
    final count = ref.read(dailyGoalProvider(totalWords: totalWords));

    if (tracked) {
      await ref.read(dailyQueueProvider.notifier).addMoreWords(count);
      
      final srsQueue = await ref.read(reviewSessionProvider.future);
      state = AsyncData(FlashcardSessionState(
        queue: List.from(srsQueue),
        mode: FlashcardSessionMode.anticipateTracked,
        initialQueueLength: srsQueue.length,
      ));
    } else {
      // Ghost Mode
      final progressQuery = await ref.read(wordProgressRepositoryProvider.future);
      final currentQueueIds = await ref.read(dailyQueueProvider.future);
      
      List<GreWord> availableWords = [];
      final todayMidnight = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

      for (final word in allWordsQuery) {
        if (currentQueueIds.contains(word.originalInput)) continue;

        final prog = progressQuery[word.originalInput];
        if (prog != null && prog.lastReviewDate != null) {
          final lrDate = DateTime(prog.lastReviewDate!.year, prog.lastReviewDate!.month, prog.lastReviewDate!.day);
          if (lrDate.isAtSameMomentAs(todayMidnight)) continue;
        }
        availableWords.add(word);
      }

      availableWords.shuffle();
      final ghostQueue = availableWords.take(count).toList();
      
      state = AsyncData(FlashcardSessionState(
        queue: ghostQueue,
        mode: FlashcardSessionMode.anticipateGhost,
        initialQueueLength: ghostQueue.length,
      ));
    }
  }

  void resetToSrs() {
    state = const AsyncLoading();
    ref.invalidateSelf();
  }
}
