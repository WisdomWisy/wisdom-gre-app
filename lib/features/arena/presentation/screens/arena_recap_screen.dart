import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisdom_gre_app/core/theme/app_theme.dart';
import 'package:wisdom_gre_app/features/arena/presentation/providers/arena_state.dart';
import 'package:wisdom_gre_app/features/arena/presentation/providers/arena_controller.dart';

class ArenaRecapScreen extends ConsumerWidget {
  final ArenaState state;

  const ArenaRecapScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeControllerProvider);

    return Column(
      children: [
        // Summary Header
        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              decoration: BoxDecoration(
                color: theme.surfaceColor.withValues(alpha: 0.7),
                border: Border(bottom: BorderSide(color: theme.textColor.withValues(alpha: 0.1))),
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    Text(
                      state.remainingTimeSeconds <= 0 && state.style == ArenaStyle.timed ? "TIME'S UP!" : "MATCH COMPLETE",
                      style: GoogleFonts.inter(
                        color: state.remainingTimeSeconds <= 0 && state.style == ArenaStyle.timed ? Colors.redAccent : const Color(0xFFED8F03),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Score: ${state.score}',
                      style: GoogleFonts.outfit(color: theme.textColor, fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        
        // Questions Recap List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: state.questions.length,
            itemBuilder: (context, index) {
              // If user hit timeout, some answers map will be missing. Only show answered ones, or show "Unanswered"
              if (!state.userAnswers.containsKey(index)) return const SizedBox.shrink();

              final question = state.questions[index];
              final userAnswers = state.userAnswers[index] ?? {};

              return Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: theme.surfaceColor.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.textColor.withValues(alpha: 0.1)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Question ${index + 1}',
                            style: GoogleFonts.inter(color: theme.textColor.withValues(alpha: 0.6), fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          _buildQuestionReview(question, userAnswers, theme),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Action
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: ElevatedButton(
            onPressed: () {
              // Reset and return home
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFED8F03),
              padding: const EdgeInsets.symmetric(vertical: 16),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: Text('Return to Home', style: GoogleFonts.outfit(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildQuestionReview(ArenaQuestion question, Map<int, String> answers, AppThemeData theme) {
    if (question.type == QuestionType.sentenceEquivalence) {
      final selectedList = answers.values.toList();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question.questionText, style: GoogleFonts.inter(fontSize: 16, color: theme.textColor)),
          const SizedBox(height: 12),
          Text('Your Choices:', style: GoogleFonts.inter(fontSize: 12, color: theme.textColor.withValues(alpha: 0.5))),
          Wrap(
            spacing: 8,
            children: selectedList.map((ans) {
              final isCorrect = question.correctAnswers.contains(ans);
              return Chip(
                label: Text(ans, style: TextStyle(color: isCorrect ? Colors.green : Colors.red)),
                backgroundColor: isCorrect ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
          Text('Correct Answers:', style: GoogleFonts.inter(fontSize: 12, color: theme.textColor.withValues(alpha: 0.5))),
          Wrap(
            spacing: 8,
            children: question.correctAnswers.map((ans) {
              return Chip(
                label: Text(ans, style: const TextStyle(color: Colors.green)),
                backgroundColor: Colors.green.withValues(alpha: 0.1),
              );
            }).toList(),
          ),
        ],
      );
    } else {
      // Text Completion
      final textParts = question.questionText.split(RegExp(r'_{3,}'));
      return RichText(
        text: TextSpan(
          style: GoogleFonts.inter(color: theme.textColor, fontSize: 16, height: 1.6),
          children: [
            for (int i = 0; i < textParts.length; i++) ...[
              TextSpan(text: textParts[i]),
              if (i < textParts.length - 1 && i < question.correctAnswers.length)
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: _buildInlineFeedbackBlank(i, question.correctAnswers[i], answers[i], theme),
                ),
            ],
          ],
        ),
      );
    }
  }

  Widget _buildInlineFeedbackBlank(int index, String correctAnswer, String? userAnswer, AppThemeData theme) {
    final bool isCorrect = correctAnswer == userAnswer;
    final color = isCorrect ? Colors.green : Colors.red;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color, width: 1.5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            userAnswer ?? '(Blank)',
            style: GoogleFonts.inter(color: color, fontWeight: FontWeight.bold, fontSize: 14),
          ),
          if (!isCorrect)
            Text(
              correctAnswer,
              style: GoogleFonts.inter(color: Colors.green, fontSize: 10, fontWeight: FontWeight.w800),
            )
        ],
      ),
    );
  }
}
