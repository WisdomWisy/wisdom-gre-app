import 'package:flutter/material.dart';
import 'package:wisdom_gre_app/features/arena/presentation/screens/arena_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisdom_gre_app/core/components/mesh_background.dart';
import 'package:wisdom_gre_app/core/theme/app_theme.dart';
import 'package:wisdom_gre_app/features/flashcards/domain/srs_helper.dart';
import 'package:wisdom_gre_app/features/flashcards/data/models/word_progress.dart';
import 'package:wisdom_gre_app/features/flashcards/presentation/widgets/flashcard_widget.dart';
import 'package:wisdom_gre_app/features/vocabulary/data/models/gre_word.dart';
import 'package:wisdom_gre_app/features/flashcards/presentation/providers/flashcard_session_controller.dart';
import 'package:wisdom_gre_app/features/flashcards/domain/review_session_provider.dart';
import 'package:wisdom_gre_app/features/dashboard/domain/providers/exam_goal_provider.dart';
import 'package:wisdom_gre_app/features/vocabulary/domain/providers/vocabulary_provider.dart';
import 'package:wisdom_gre_app/features/subscriptions/domain/subscription_provider.dart';
import 'package:wisdom_gre_app/features/subscriptions/presentation/paywall_screen.dart';
import 'dart:ui';

class FlashcardScreen extends ConsumerStatefulWidget {
  const FlashcardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends ConsumerState<FlashcardScreen> {
  bool _isFront = true;

  void _flipCard() {
    setState(() {
      _isFront = !_isFront;
    });
  }

  void _rateWord(GreWord word, ReviewGrade grade) {
    ref.read(flashcardSessionControllerProvider.notifier).rateWord(grade);
    
    setState(() {
      _isFront = true;
    });
  }

  void _showAnticipateDialog(AppThemeData theme) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.surfaceColor.withOpacity(0.8),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                border: Border(top: BorderSide(color: theme.textColor.withOpacity(0.1))),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.psychology_alt, size: 48, color: Color(0xFFED8F03)),
                    const SizedBox(height: 16),
                    Text(
                      'Anticipation Mode',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: theme.textColor),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Do you want to save this session in your Spaced Repetition learning curve?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: theme.textColor.withOpacity(0.8)),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFED8F03),
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        final success = await ref.read(flashcardSessionControllerProvider.notifier).startAnticipation(true);
                        if (!success && mounted) {
                          _showPremiumPaywall(theme);
                        }
                      },
                      child: const Text('Yes, track progress', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: theme.textColor,
                        minimumSize: const Size(double.infinity, 56),
                        side: BorderSide(color: theme.textColor.withOpacity(0.5)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        final success = await ref.read(flashcardSessionControllerProvider.notifier).startAnticipation(false);
                        if (!success && mounted) {
                          _showPremiumPaywall(theme);
                        }
                      },
                      child: Text('No, Ghost Mode', style: TextStyle(color: theme.textColor, fontSize: 18)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showPremiumPaywall(AppThemeData theme) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: theme.surfaceColor,
          title: Row(
            children: [
              const Icon(Icons.workspace_premium, color: Colors.amber, size: 32),
              const SizedBox(width: 8),
              Text('Premium Required', style: TextStyle(color: theme.textColor)),
            ],
          ),
          content: Text(
            "You've reached your daily free limit. Unlock everything to conquer the GRE!",
            style: TextStyle(color: theme.textColor),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Maybe Later', style: TextStyle(color: theme.textColor.withOpacity(0.7))),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber[700],
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PaywallScreen()));
              },
              child: const Text('View Premium Plans'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = ref.watch(themeControllerProvider);
    final sessionAsync = ref.watch(flashcardSessionControllerProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: themeData.textColor),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Force reset to SRS when leaving so it doesn't stay stuck in Ghost Mode forever
            ref.read(flashcardSessionControllerProvider.notifier).resetToSrs();
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.restart_alt, color: themeData.textColor),
            tooltip: 'Reset Progress',
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  backgroundColor: themeData.surfaceColor,
                  title: Text('Reset Progress?', style: TextStyle(color: themeData.textColor)),
                  content: Text(
                    'This will erase all your flashcard progress and start from scratch. Are you sure?',
                    style: TextStyle(color: themeData.textColor),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: Text('Cancel', style: TextStyle(color: themeData.textColor.withOpacity(0.7))),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                      onPressed: () {
                        ref.read(wordProgressRepositoryProvider.notifier).resetAllProgress();
                        ref.read(flashcardSessionControllerProvider.notifier).resetToSrs();
                        Navigator.pop(ctx);
                      },
                      child: const Text('Reset', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: MeshBackground(
        child: sessionAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(
            child: Text(
              'Error loading session: $err',
              style: TextStyle(color: themeData.textColor),
            ),
          ),
          data: (sessionState) {
            final queue = sessionState.queue;

            if (queue.isEmpty) {
              final totalWordsAsync = ref.watch(vocabularyProvider);
              final totalWords = totalWordsAsync.valueOrNull?.length ?? 0;
              final dailyGoal = ref.watch(dailyGoalProvider(totalWords: totalWords));

              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.celebration, size: 80, color: themeData.textColor),
                      const SizedBox(height: 24),
                      Text(
                        sessionState.mode == FlashcardSessionMode.srs 
                            ? 'You are all caught up!' 
                            : 'Session Complete!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: themeData.textColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        sessionState.mode == FlashcardSessionMode.srs 
                            ? 'Come back tomorrow for more reviews.'
                            : 'Want to keep going?',
                        style: TextStyle(
                          fontSize: 16,
                          color: themeData.textColor.withOpacity(0.8),
                        ),
                      ),
                      if (sessionState.mode == FlashcardSessionMode.srs) ...[
                        const SizedBox(height: 32),
                        OutlinedButton.icon(
                          onPressed: () async {
                            final isPremium = await ref.read(subscriptionStatusProvider.future);
                            if (!isPremium && context.mounted) {
                               Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PaywallScreen()));
                               return;
                            }
                            _showAnticipateDialog(themeData);
                          },
                          icon: Icon(Icons.fast_forward, color: themeData.textColor),
                          label: Text('Anticipate $dailyGoal words', style: TextStyle(color: themeData.textColor)),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: themeData.textColor.withOpacity(0.5)),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton.icon(
                          onPressed: () {
                            ref.read(flashcardSessionControllerProvider.notifier).startReviewAgain();
                          },
                          icon: Icon(Icons.history, color: themeData.textColor),
                          label: Text('Review today\'s words again', style: TextStyle(color: themeData.textColor)),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: themeData.textColor.withOpacity(0.5)),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ],
                      if (sessionState.mode != FlashcardSessionMode.srs) ...[
                        const SizedBox(height: 32),
                        ElevatedButton.icon(
                          onPressed: () {
                            ref.read(flashcardSessionControllerProvider.notifier).resetToSrs();
                          },
                          icon: const Icon(Icons.check, color: Colors.white),
                          label: const Text('Finish Extra Study', style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFED8F03),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                        ),
                      ],
                      const SizedBox(height: 48),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ArenaScreen()));
                        },
                        icon: const Icon(Icons.shield, color: Colors.white),
                        label: const Text(
                          'Test your knowledge in the Arena!',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFED8F03),
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          elevation: 10,
                          shadowColor: const Color(0xFFED8F03).withOpacity(0.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            final currentWord = queue.first;
            
            String modeBadge = '';
            if (sessionState.mode == FlashcardSessionMode.anticipateGhost) modeBadge = 'GHOST MODE';
            if (sessionState.mode == FlashcardSessionMode.anticipateTracked) modeBadge = 'ANTICIPATING (TRACKED)';
            if (sessionState.mode == FlashcardSessionMode.reviewAgain) modeBadge = 'REVIEWING';

            final isPremium = ref.watch(subscriptionStatusProvider).value ?? false;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Column(
                children: [
                  if (!isPremium && sessionState.mode == FlashcardSessionMode.srs)
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.amber.withOpacity(0.5)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.lock_clock, color: Colors.amber, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Free Daily Limit Active (Max 5). Unlock Platinium for unlimited!',
                              style: TextStyle(color: themeData.textColor, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  // Progress Text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${queue.length} words remaining',
                        style: TextStyle(
                          color: themeData.textColor.withOpacity(0.7),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (modeBadge.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: sessionState.mode == FlashcardSessionMode.anticipateGhost ? Colors.grey.withOpacity(0.3) : const Color(0xFFED8F03).withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            modeBadge,
                            style: TextStyle(
                              color: sessionState.mode == FlashcardSessionMode.anticipateGhost ? Colors.grey : const Color(0xFFED8F03),
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Flashcard taking most of the screen
                  Expanded(
                    child: FlashcardWidget(
                      key: ValueKey(currentWord.originalInput), // Force rebuild on new word
                      word: currentWord,
                      isFront: _isFront,
                      onFlip: _flipCard,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Grading Buttons (Only visible on Back)
                  AnimatedOpacity(
                    opacity: !_isFront ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: IgnorePointer(
                      ignoring: _isFront,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildGradeButton(context, themeData, currentWord, ReviewGrade.hard, 'Hard', Colors.redAccent),
                          _buildGradeButton(context, themeData, currentWord, ReviewGrade.good, 'Good', Colors.orangeAccent),
                          _buildGradeButton(context, themeData, currentWord, ReviewGrade.easy, 'Easy', Colors.greenAccent),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGradeButton(
    BuildContext context, 
    AppThemeData themeData, 
    GreWord word, 
    ReviewGrade grade, 
    String label, 
    Color color
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
         backgroundColor: color.withOpacity(0.2),
         foregroundColor: color,
         elevation: 0,
         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(16),
           side: BorderSide(color: color, width: 2),
         )
      ),
      onPressed: () => _rateWord(word, grade),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
