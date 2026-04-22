import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wisdom_gre_app/features/auth/domain/auth_state_provider.dart';
import 'package:wisdom_gre_app/features/vocabulary/domain/providers/vocabulary_provider.dart';
import 'package:wisdom_gre_app/features/flashcards/domain/review_session_provider.dart';

part 'stats_controller.g.dart';

class ProfileStatsState {
  final int arenaWins;
  final int arenaLosses;
  final int currentStreak;
  final int totalWords;
  final int masteredWords;
  final int learningWords;
  final int toReviewWords;

  ProfileStatsState({
    required this.arenaWins,
    required this.arenaLosses,
    required this.currentStreak,
    required this.totalWords,
    required this.masteredWords,
    required this.learningWords,
    required this.toReviewWords,
  });
}

@riverpod
class StatsController extends _$StatsController {
  @override
  FutureOr<ProfileStatsState> build() async {
    // Silently validate streak in the background
    StreakService.validateDailyStreak();

    // 1. Fetch Profile for Arena Stats
    final profile = await ref.watch(userProfileProvider.future);
    
    // 2. Fetch Vocabulary
    final vocabulary = await ref.watch(vocabularyProvider.future);
    final totalWords = vocabulary.length;

    // 3. Fetch Word Progress
    final progressMap = await ref.watch(wordProgressRepositoryProvider.future);

    int mastered = 0;
    int learning = 0;

    for (final prog in progressMap.values) {
      if (prog.interval > 21) {
        mastered++;
      } else if (prog.interval > 0 && prog.interval <= 21) {
        learning++;
      }
    }

    final toReview = totalWords - (mastered + learning);

    return ProfileStatsState(
      arenaWins: profile?.arenaWins ?? 0,
      arenaLosses: profile?.arenaLosses ?? 0,
      currentStreak: profile?.currentStreak ?? 1,
      totalWords: totalWords,
      masteredWords: mastered,
      learningWords: learning,
      toReviewWords: toReview,
    );
  }
}

class StreakService {
  static const String _lastLoginKey = 'last_login_date';

  /// Validates the streak silently in the background
  static Future<void> validateDailyStreak() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final prefs = await SharedPreferences.getInstance();
    final lastLoginStr = prefs.getString(_lastLoginKey);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (lastLoginStr == null) {
      // First time login
      await prefs.setString(_lastLoginKey, today.toIso8601String());
      return;
    }

    final lastLoginDate = DateTime.parse(lastLoginStr);
    final lastLoginMidnight = DateTime(lastLoginDate.year, lastLoginDate.month, lastLoginDate.day);
    
    final differenceInDays = today.difference(lastLoginMidnight).inDays;

    if (differenceInDays == 0) {
      // Same day, do nothing
      return;
    }

    try {
      if (differenceInDays == 1) {
        // Next day (+1), Increment Streak
        // Fetch current streak first since we can't increment natively without RPC
        final data = await Supabase.instance.client.from('profiles').select('current_streak').eq('id', user.id).single();
        final currentStreak = data['current_streak'] as int? ?? 0;
        await Supabase.instance.client.from('profiles').update({'current_streak': currentStreak + 1}).eq('id', user.id);
      } else if (differenceInDays > 1) {
        // Streak broken
        await Supabase.instance.client.from('profiles').update({'current_streak': 1}).eq('id', user.id);
      }
      // Update local storage
      await prefs.setString(_lastLoginKey, today.toIso8601String());
    } catch (e) {
      // Fail silently for background task
    }
  }
}
