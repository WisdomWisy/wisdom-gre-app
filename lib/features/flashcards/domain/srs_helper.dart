import 'package:wisdom_gre_app/features/flashcards/data/models/word_progress.dart';

enum ReviewGrade {
  hard,
  good,
  easy,
}

class SRSHelper {
  /// Applies a simplified SM-2 Algorithm based on user feedback.
  static WordProgress calculateNextReview(WordProgress current, ReviewGrade grade) {
    int repetitions = current.repetitions;
    double easiness = current.easinessFactor;
    int interval = current.interval;

    if (grade == ReviewGrade.hard) {
      // Re-start repetitions, slightly reduce easiness
      repetitions = 0;
      interval = 1;
      easiness = (easiness - 0.2).clamp(1.3, 2.5);
    } else {
      repetitions += 1;

      if (grade == ReviewGrade.good) {
        if (interval == 0) {
          interval = 1;
        } else if (interval == 1) {
          interval = 3; // First successful interval
        } else {
          interval = (interval * easiness).round();
        }
      } else if (grade == ReviewGrade.easy) {
        // Increase easiness and jump interval faster
        easiness = (easiness + 0.1).clamp(1.3, 2.5);
        if (interval == 0) {
          interval = 2; // Jump ahead if easy on first try
        } else if (interval == 1) {
          interval = 4;
        } else {
          interval = (interval * (easiness + 0.1)).round();
        }
      }
    }

    // Set exactly at midnight to avoid intra-day shifts
    final now = DateTime.now();
    final nextReviewDate = DateTime(now.year, now.month, now.day).add(Duration(days: interval));

    return current.copyWith(
      repetitions: repetitions,
      easinessFactor: easiness,
      interval: interval,
      nextReviewDate: nextReviewDate,
    );
  }
}
