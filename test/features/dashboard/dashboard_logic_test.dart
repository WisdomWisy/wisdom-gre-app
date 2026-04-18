import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisdom_gre_app/features/dashboard/domain/providers/exam_goal_provider.dart';

void main() {
  group('Daily Goal Calculation', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('Goal is 0 when no date is set', () {
      final goal = container.read(dailyGoalProvider(totalWords: 1000));
      expect(goal, 0);
    });

    test('Goal is 0 when total words is 0', () {
      // Set date to 10 days from now
      final date = DateTime.now().add(const Duration(days: 10));
      container.read(examDateProvider.notifier).setDate(date);

      final goal = container.read(dailyGoalProvider(totalWords: 0));
      expect(goal, 0);
    });

    test('Goal is bounded to total words if days remaining <= 0', () {
      // Exam is yesterday
      final date = DateTime.now().subtract(const Duration(days: 1));
      container.read(examDateProvider.notifier).setDate(date);

      final goal = container.read(dailyGoalProvider(totalWords: 1000));
      expect(goal, 1000);
    });

    test('Goal correctly calculates (Total / Days) + 10% ceiling', () {
      // Exam exactly 10 days from today at midnight
      final now = DateTime.now();
      final date = DateTime(now.year, now.month, now.day).add(const Duration(days: 10));
      container.read(examDateProvider.notifier).setDate(date);

      // (1000 / 10) * 1.1 = 110.0 -> ceil is 110
      final goal = container.read(dailyGoalProvider(totalWords: 1000));
      expect(goal, 110);
    });

    test('Goal calculates ceiling correctly for uneven splits', () {
      final now = DateTime.now();
      final date = DateTime(now.year, now.month, now.day).add(const Duration(days: 7));
      container.read(examDateProvider.notifier).setDate(date);

      // (1000 / 7) * 1.1 = 142.857 * 1.1 = 157.14 -> ceil is 158
      final goal = container.read(dailyGoalProvider(totalWords: 1000));
      expect(goal, 158);
    });
    
    test('Goal doesn\'t exceed total words', () {
      final now = DateTime.now();
      // Exam is 1 day away
      final date = DateTime(now.year, now.month, now.day).add(const Duration(days: 1));
      container.read(examDateProvider.notifier).setDate(date);

      // (10 / 1) * 1.1 = 11. Ceil is 11, but totalWords is 10. Should return 10.
      final goal = container.read(dailyGoalProvider(totalWords: 10));
      expect(goal, 10);
    });
  });
}
