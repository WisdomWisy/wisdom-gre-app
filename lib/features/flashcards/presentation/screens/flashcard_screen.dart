import 'package:flutter/material.dart';
import 'package:wisdom_gre_app/features/arena/presentation/screens/arena_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisdom_gre_app/core/components/mesh_background.dart';
import 'package:wisdom_gre_app/core/theme/app_theme.dart';
import 'package:wisdom_gre_app/features/flashcards/domain/review_session_provider.dart';
import 'package:wisdom_gre_app/features/flashcards/domain/srs_helper.dart';
import 'package:wisdom_gre_app/features/flashcards/data/models/word_progress.dart';
import 'package:wisdom_gre_app/features/flashcards/presentation/widgets/flashcard_widget.dart';
import 'package:wisdom_gre_app/features/vocabulary/data/models/gre_word.dart';

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

  void _rateWord(GreWord word, WordProgress? currentProgress, ReviewGrade grade) {
    // Determine current state of progress or create a new one
    final progress = currentProgress ?? WordProgress(wordId: word.originalInput, nextReviewDate: DateTime.now());
    
    // Calculate new progress via SRS algorithm
    final newProgress = SRSHelper.calculateNextReview(progress, grade);

    // Save to repository (this will invalidate the session and pop the queue)
    ref.read(wordProgressRepositoryProvider.notifier).saveProgress(newProgress);
    
    // Reset state for the next card immediately for UI smoothness
    setState(() {
      _isFront = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = ref.watch(themeControllerProvider);
    final sessionAsync = ref.watch(reviewSessionProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: themeData.textColor),
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
          data: (queue) {
            if (queue.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.celebration, size: 80, color: themeData.textColor),
                    const SizedBox(height: 24),
                    Text(
                      'You are all caught up!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: themeData.textColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Come back tomorrow for more reviews.',
                      style: TextStyle(
                        fontSize: 16,
                        color: themeData.textColor.withOpacity(0.8),
                      ),
                    ),
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
              );
            }

            final currentWord = queue.first;
            
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Column(
                children: [
                  // Progress Text
                  Text(
                    '${queue.length} words remaining',
                    style: TextStyle(
                      color: themeData.textColor.withOpacity(0.7),
                      fontWeight: FontWeight.bold,
                    ),
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
    // We safely watch the future so we easily access current progress
    final progressMapAsync = ref.watch(wordProgressRepositoryProvider);
    final currentProgress = progressMapAsync.valueOrNull?[word.originalInput];

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
      onPressed: () => _rateWord(word, currentProgress, grade),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
