import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisdom_gre_app/features/vocabulary/domain/providers/vocabulary_provider.dart';
import 'package:wisdom_gre_app/features/flashcards/data/models/word_progress.dart';
import 'package:wisdom_gre_app/features/dashboard/domain/providers/exam_goal_provider.dart';
import 'package:wisdom_gre_app/features/vocabulary/data/models/gre_word.dart';
import 'package:wisdom_gre_app/features/subscriptions/domain/subscription_provider.dart';

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

  Future<void> resetAllProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_progressKey);
    state = const AsyncData({});
    ref.invalidate(reviewSessionProvider);
  }
}

const _dailyQueueKey = 'daily_queue_cache';
const _dailyQueueDateKey = 'daily_queue_date';

@riverpod
class DailyQueue extends _$DailyQueue {
  @override
  FutureOr<List<String>> build() async {
    final prefs = await SharedPreferences.getInstance();
    final queueDateStr = prefs.getString(_dailyQueueDateKey);
    final now = DateTime.now();
    final todayStr = "${now.year}-${now.month}-${now.day}";

    if (queueDateStr == todayStr) {
      final queueStr = prefs.getString(_dailyQueueKey);
      if (queueStr != null) {
        final List<dynamic> jsonList = jsonDecode(queueStr);
        return jsonList.cast<String>();
      }
    }
    // Otherwise, generate a new queue for today
    return _generateNewQueue(todayStr);
  }

  Future<List<String>> _generateNewQueue(String todayStr) async {
    final allWordsQuery = await ref.watch(vocabularyProvider.future);
    final progressQuery = await ref.watch(wordProgressRepositoryProvider.future);
    final totalWords = allWordsQuery.length;
    final goal = ref.read(dailyGoalProvider(totalWords: totalWords));

    final todayMidnight = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    int reviewedTodayCount = 0;

    List<GreWord> dueWords = [];
    List<GreWord> newWords = [];

    for (final word in allWordsQuery) {
      final prog = progressQuery[word.originalInput];
      if (prog == null) {
        newWords.add(word);
      } else {
        if (prog.lastReviewDate != null) {
          final lrDate = DateTime(prog.lastReviewDate!.year, prog.lastReviewDate!.month, prog.lastReviewDate!.day);
          if (lrDate.isAtSameMomentAs(todayMidnight)) {
            reviewedTodayCount++;
            continue;
          }
        }
        final reviewDate = DateTime(prog.nextReviewDate.year, prog.nextReviewDate.month, prog.nextReviewDate.day);
        if (reviewDate.compareTo(todayMidnight) <= 0) {
          dueWords.add(word);
        }
      }
    }

    int remainingGoal = (goal > 0 ? goal : 50) - reviewedTodayCount;

    if (remainingGoal <= 0) return [];

    dueWords.shuffle();
    newWords.shuffle();

    final session = <GreWord>[...dueWords, ...newWords];
    final queueIds = session.take(remainingGoal).map((e) => e.originalInput).toList();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_dailyQueueDateKey, todayStr);
    await prefs.setString(_dailyQueueKey, jsonEncode(queueIds));

    return queueIds;
  }

  Future<void> addMoreWords(int count) async {
    final allWordsQuery = await ref.read(vocabularyProvider.future);
    final progressQuery = await ref.read(wordProgressRepositoryProvider.future);
    final currentQueue = state.valueOrNull ?? [];

    final todayMidnight = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    List<GreWord> availableWords = [];

    for (final word in allWordsQuery) {
      if (currentQueue.contains(word.originalInput)) continue;

      final prog = progressQuery[word.originalInput];
      if (prog != null && prog.lastReviewDate != null) {
        final lrDate = DateTime(prog.lastReviewDate!.year, prog.lastReviewDate!.month, prog.lastReviewDate!.day);
        if (lrDate.isAtSameMomentAs(todayMidnight)) continue;
      }
      availableWords.add(word);
    }

    availableWords.shuffle();
    final newIds = availableWords.take(count).map((e) => e.originalInput).toList();

    if (newIds.isEmpty) return;

    final updatedQueue = [...currentQueue, ...newIds];
    state = AsyncData(updatedQueue);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_dailyQueueKey, jsonEncode(updatedQueue));
  }
}

/// Represents the active session queue for the day (excluding already reviewed)
@riverpod
Future<List<GreWord>> reviewSession(ReviewSessionRef ref) async {
  final queueIds = await ref.watch(dailyQueueProvider.future);
  final allWordsQuery = await ref.watch(vocabularyProvider.future);
  final progressQuery = await ref.watch(wordProgressRepositoryProvider.future);

  final todayMidnight = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  List<GreWord> session = [];

  final isPremium = await ref.watch(subscriptionStatusProvider.future);
  int limit = queueIds.length;
  // If not premium, limit the total daily session to 5 words
  if (!isPremium) {
    int reviewedTodayCount = 0;
    for (final prog in progressQuery.values) {
      if (prog.lastReviewDate != null) {
        final lrDate = DateTime(prog.lastReviewDate!.year, prog.lastReviewDate!.month, prog.lastReviewDate!.day);
        if (lrDate.isAtSameMomentAs(todayMidnight)) {
          reviewedTodayCount++;
        }
      }
    }
    int maxAllowed = 5 - reviewedTodayCount;
    if (maxAllowed < 0) maxAllowed = 0;
    limit = maxAllowed;
  }
  
  final allowedIds = queueIds.take(limit).toList();

  for (final id in allowedIds) {
    try {
      final word = allWordsQuery.firstWhere((w) => w.originalInput == id);
      
      // Filter out if reviewed today
      final prog = progressQuery[id];
      if (prog != null && prog.lastReviewDate != null) {
        final lrDate = DateTime(prog.lastReviewDate!.year, prog.lastReviewDate!.month, prog.lastReviewDate!.day);
        if (lrDate.isAtSameMomentAs(todayMidnight)) continue;
      }
      
      session.add(word);
    } catch (_) {
      // Word not found in DB
    }
  }

  return session;
}

/// Represents the full daily list (including already reviewed)
@riverpod
Future<List<GreWord>> dailyWordsList(DailyWordsListRef ref) async {
  final queueIds = await ref.watch(dailyQueueProvider.future);
  final allWordsQuery = await ref.watch(vocabularyProvider.future);
  final progressQuery = await ref.watch(wordProgressRepositoryProvider.future);
  
  final todayMidnight = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  
  final isPremium = await ref.watch(subscriptionStatusProvider.future);
  
  final List<GreWord> fullList = allWordsQuery.where((w) {
    // 1. In daily queue cache
    if (queueIds.contains(w.originalInput)) return true;
    
    // 2. Studied today (catches reviews from before cache or anticipated words)
    final prog = progressQuery[w.originalInput];
    if (prog != null && prog.lastReviewDate != null) {
      final lrDate = DateTime(prog.lastReviewDate!.year, prog.lastReviewDate!.month, prog.lastReviewDate!.day);
      if (lrDate.isAtSameMomentAs(todayMidnight)) return true;
    }
    
    return false;
  }).toList();
  
  if (!isPremium && fullList.length > 5) {
    return fullList.take(5).toList();
  }
  return fullList;
}
