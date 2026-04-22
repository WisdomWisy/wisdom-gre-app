import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'exam_goal_provider.g.dart';

@riverpod
class ExamDate extends _$ExamDate {
  static const _key = 'exam_date_pref';

  @override
  DateTime? build() {
    _loadDate();
    return null; // Initial state while loading
  }

  Future<void> _loadDate() async {
    final prefs = await SharedPreferences.getInstance();
    final dateStr = prefs.getString(_key);
    if (dateStr != null) {
      state = DateTime.tryParse(dateStr);
    }
  }

  Future<void> setDate(DateTime date) async {
    state = date;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, date.toIso8601String());
  }
}

@riverpod
int dailyGoal(DailyGoalRef ref, {required int totalWords}) {
  final examDate = ref.watch(examDateProvider);
  
  if (examDate == null || totalWords == 0) {
    return 0;
  }

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final examDay = DateTime(examDate.year, examDate.month, examDate.day);
  
  final difference = examDay.difference(today).inDays;

  // If the exam is today or in the past, the goal is everything
  if (difference <= 0) {
    return totalWords;
  }

  // Goal = (Total words / Days remaining) + 10%
  // Using integer multiplication before division avoids floating point inaccuracies like 100 * 1.1 = 110.00000000000001
  final goal = ((totalWords * 11) / (difference * 10)).ceil();
  
  // Ensure we don't return a goal larger than total words
  return goal > totalWords ? totalWords : goal;
}
