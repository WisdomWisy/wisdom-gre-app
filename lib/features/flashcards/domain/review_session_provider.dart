import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisdom_gre_app/features/vocabulary/domain/providers/vocabulary_provider.dart';
import 'package:wisdom_gre_app/features/flashcards/data/models/word_progress.dart';
import 'package:wisdom_gre_app/features/dashboard/domain/providers/exam_goal_provider.dart';
import 'package:wisdom_gre_app/features/vocabulary/data/models/gre_word.dart';

part 'review_session_provider.g.dart';

const _progressKey = 'gre_word_progress';

@riverpod
class WordProgressRepository extends _$WordProgressRepository {
  @override
  FutureOr<Map<String, WordProgress>> build() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_progressKey);
    if (jsonStr == null) return {};

    final Map<String, dynamic> map = json.decode(jsonStr);
    return map.map((key, value) => MapEntry(key, WordProgress.fromJson(value)));
  }

  Future<void> saveProgress(WordProgress progress) async {
    final currentState = state.valueOrNull ?? {};
    final newState = {...currentState, progress.wordId: progress};
    
    // Update local state and save to SharedPreferences
    state = AsyncData(newState);
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = json.encode(newState.map((k, v) => MapEntry(k, v.toJson())));
    await prefs.setString(_progressKey, jsonStr);

    // Refresh the session so the reviewed word leaves the queue
    ref.invalidate(reviewSessionProvider);
  }
}

/// Represents the session queue for the day
@riverpod
Future<List<GreWord>> reviewSession(ReviewSessionRef ref) async {
  final allWordsQuery = await ref.watch(vocabularyProvider.future);
  final progressQuery = await ref.watch(wordProgressRepositoryProvider.future);
  
  // Total words for calculating daily goal
  final totalWords = allWordsQuery.length;
  final goal = ref.watch(dailyGoalProvider(totalWords: totalWords));

  final now = DateTime.now();
  final todayMidnight = DateTime(now.year, now.month, now.day);

  List<GreWord> dueWords = [];
  List<GreWord> newWords = [];

  for (final word in allWordsQuery) {
    final prog = progressQuery[word.originalInput];
    if (prog == null) {
      newWords.add(word);
    } else {
      // If nextReviewDate is today or past
      final reviewDate = DateTime(prog.nextReviewDate.year, prog.nextReviewDate.month, prog.nextReviewDate.day);
      if (reviewDate.compareTo(todayMidnight) <= 0) {
        dueWords.add(word);
      }
    }
  }

  // Shuffle to randomize learning (optional but good for retention)
  dueWords.shuffle();
  newWords.shuffle();

  // Combine. Prioritize due over new, up to the goal.
  final session = <GreWord>[];
  session.addAll(dueWords);
  session.addAll(newWords);

  return session.take(goal > 0 ? goal : 50).toList(); // Safe fallback to 50 if goal is 0 somehow
}
