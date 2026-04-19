import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisdom_gre_app/features/arena/presentation/providers/arena_controller.dart';
import 'package:wisdom_gre_app/features/arena/presentation/providers/arena_state.dart';
import 'package:wisdom_gre_app/core/theme/app_theme.dart'; // Using the user's theme if available
import 'package:wisdom_gre_app/core/components/mesh_background.dart';
import 'package:wisdom_gre_app/features/arena/presentation/widgets/arena_settings_dialog.dart';
import 'package:wisdom_gre_app/features/arena/presentation/screens/arena_recap_screen.dart';

class ArenaScreen extends ConsumerStatefulWidget {
  const ArenaScreen({super.key});

  @override
  ConsumerState<ArenaScreen> createState() => _ArenaScreenState();
}

class _ArenaScreenState extends ConsumerState<ArenaScreen> {
  // Store the user's selected answers for the current question
  late Map<int, String> _selectedAnswers;

  @override
  void initState() {
    super.initState();
    _selectedAnswers = {};
    // We intentionally do NOT auto-load here so the user lands in the Lobby first!
  }

  void _resetSelection() {
    setState(() {
      _selectedAnswers.clear();
    });
  }

  void _showAnswerOptions(BuildContext context, int blankIndex, List<String> options) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                spreadRadius: 5,
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Answer for Blank ${blankIndex + 1}',
                    style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ...options.map((option) {
                    return ListTile(
                      title: Text(option, style: GoogleFonts.inter(fontSize: 16)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      onTap: () {
                        setState(() {
                          _selectedAnswers[blankIndex] = option;
                        });
                        Navigator.pop(context);
                      },
                      tileColor: _selectedAnswers[blankIndex] == option
                          ? const Color(0xFFED8F03).withOpacity(0.1)
                          : null,
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool _isAnswerCorrect(ArenaQuestion question) {
    if (question.type == QuestionType.sentenceEquivalence) {
      if (_selectedAnswers.length < 2) return false;
      final selected = _selectedAnswers.values.toList();
      return question.correctAnswers.contains(selected[0]) &&
          question.correctAnswers.contains(selected[1]);
    } else {
      // Text Completions
      for (int i = 0; i < question.correctAnswers.length; i++) {
        if (_selectedAnswers[i] != question.correctAnswers[i]) {
          return false;
        }
      }
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(arenaControllerProvider);

    return Scaffold(
      backgroundColor: Colors.transparent, // Important for MeshBackground
      appBar: AppBar(
        title: Text(
          'The Arena',
          style: GoogleFonts.outfit(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1E1E2C), Color(0xFF2D2D44)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => const ArenaSettingsDialog(),
              );
            },
          )
        ],
      ),
      body: MeshBackground(
        child: SafeArea(
          child: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : state.isFinished
                  ? _buildFinishedScreen(state)
                  : (state.questions.isEmpty ? _buildLobbyScreen() : _buildQuizScreen(context, state)),
        ),
      ),
    );
  }

  Widget _buildFinishedScreen(ArenaState state) {
    return ArenaRecapScreen(state: state);
  }

  Widget _buildQuizScreen(BuildContext context, ArenaState state) {
    final question = state.questions[state.currentIndex];

    // Splitting question text by blank lines
    final textParts = question.questionText.split(RegExp(r'_{3,}'));

    final theme = ref.watch(themeControllerProvider);

    return Column(
      children: [
        // Premium Header
        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: theme.surfaceColor.withValues(alpha: 0.7),
                border: Border(bottom: BorderSide(color: theme.textColor.withValues(alpha: 0.1))),
              ),
              child: Row(
                mainAxisAlignment: state.style == ArenaStyle.timed ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
                children: [
                  if (state.style == ArenaStyle.learning) ...[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('GRE Score', style: GoogleFonts.inter(color: theme.textColor.withValues(alpha: 0.6), fontSize: 12)),
                        Text('${state.score}', style: GoogleFonts.outfit(color: theme.textColor, fontSize: 24, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFFB75E), Color(0xFFED8F03)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.local_fire_department, color: Colors.white, size: 16),
                          const SizedBox(width: 4),
                          Text('x${state.streakMultiplier}', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                  if (state.style == ArenaStyle.timed)
                    Column(
                      children: [
                        Text('TIME REMAINING', style: GoogleFonts.inter(color: theme.textColor.withValues(alpha: 0.6), fontSize: 10, letterSpacing: 1.2, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(
                          '${(state.remainingTimeSeconds ~/ 60).toString().padLeft(2, '0')}:${(state.remainingTimeSeconds % 60).toString().padLeft(2, '0')}',
                          style: GoogleFonts.outfit(
                            color: state.remainingTimeSeconds <= 60 ? Colors.redAccent : theme.textColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
        
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      question.type == QuestionType.sentenceEquivalence
                          ? 'Sentence Equivalence'
                          : 'Text Completion',
                      style: GoogleFonts.inter(color: const Color(0xFFED8F03), fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Text(
                      'Question ${state.currentIndex + 1} of ${state.questions.length}',
                      style: GoogleFonts.inter(color: theme.textColor.withValues(alpha: 0.5), fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Question Card
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: theme.surfaceColor.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: theme.textColor.withValues(alpha: 0.1)),
                        ),
                        child: SingleChildScrollView(
                          child: RichText(
                            text: TextSpan(
                              style: GoogleFonts.inter(color: theme.textColor, fontSize: 18, height: 1.6),
                              children: [
                                for (int i = 0; i < textParts.length; i++) ...[
                                  TextSpan(text: textParts[i]),
                              if (i < textParts.length - 1 && i < question.correctAnswers.length)
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (state.isAnswerRevealed) return;
                                      if (question.type != QuestionType.sentenceEquivalence) {
                                        _showAnswerOptions(context, i, question.options[i]);
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                      margin: const EdgeInsets.symmetric(horizontal: 4),
                                      decoration: BoxDecoration(
                                        color: state.isAnswerRevealed
                                            ? (_selectedAnswers[i] == question.correctAnswers[i] ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1))
                                            : (_selectedAnswers.containsKey(i) ? const Color(0xFFED8F03).withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1)),
                                        border: Border.all(
                                          color: state.isAnswerRevealed
                                              ? (_selectedAnswers[i] == question.correctAnswers[i] ? Colors.green : Colors.red)
                                              : (_selectedAnswers.containsKey(i) ? const Color(0xFFED8F03) : Colors.grey),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            _selectedAnswers[i] ?? 'Tap to select',
                                            style: GoogleFonts.inter(
                                              color: state.isAnswerRevealed
                                                  ? (_selectedAnswers[i] == question.correctAnswers[i] ? Colors.green : Colors.red)
                                                  : (_selectedAnswers.containsKey(i) ? const Color(0xFFED8F03) : Colors.grey),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          if (state.isAnswerRevealed && _selectedAnswers[i] != question.correctAnswers[i])
                                            Text(
                                              question.correctAnswers[i],
                                              style: GoogleFonts.inter(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
                
                if (question.type == QuestionType.sentenceEquivalence)
                  ...[
                    const SizedBox(height: 24),
                    Text('Select exactly two options:', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: question.options[0].map((option) {
                        final isSelected = _selectedAnswers.containsValue(option);
                        return ChoiceChip(
                          label: Text(option),
                          selected: isSelected || (state.isAnswerRevealed && question.correctAnswers.contains(option)),
                          onSelected: state.isAnswerRevealed ? null : (selected) {
                            setState(() {
                              if (selected) {
                                if (_selectedAnswers.length < 2) {
                                  _selectedAnswers[_selectedAnswers.length] = option;
                                }
                              } else {
                                final key = _selectedAnswers.keys.firstWhere((k) => _selectedAnswers[k] == option);
                                _selectedAnswers.remove(key);
                              }
                            });
                          },
                          selectedColor: state.isAnswerRevealed
                              ? (question.correctAnswers.contains(option) ? Colors.green.withValues(alpha: 0.2) : (isSelected ? Colors.red.withValues(alpha: 0.2) : null))
                              : const Color(0xFFED8F03).withValues(alpha: 0.2),
                          labelStyle: GoogleFonts.inter(
                            color: state.isAnswerRevealed
                                ? (question.correctAnswers.contains(option) ? Colors.green : (isSelected ? Colors.red : Colors.black87))
                                : (isSelected ? const Color(0xFFED8F03) : Colors.black87),
                            fontWeight: isSelected || (state.isAnswerRevealed && question.correctAnswers.contains(option)) ? FontWeight.bold : FontWeight.normal,
                          ),
                        );
                      }).toList(),
                    ),
                  ],

                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (state.isAnswerRevealed) {
                      ref.read(arenaControllerProvider.notifier).nextQuestionAction();
                      _resetSelection();
                      return;
                    }

                    // Check if they filled all answers required
                    bool allFilled = true;
                    if (question.type == QuestionType.sentenceEquivalence) {
                      if (_selectedAnswers.length != 2) allFilled = false;
                    } else {
                      if (_selectedAnswers.length != question.correctAnswers.length) allFilled = false;
                    }

                    if (!allFilled) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all blanks or select required options.')));
                      return;
                    }

                    final correct = _isAnswerCorrect(question);
                    ref.read(arenaControllerProvider.notifier).submitAnswer(correct, question.type, Map.from(_selectedAnswers));
                    
                    if (state.style == ArenaStyle.timed) {
                      _resetSelection();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: state.isAnswerRevealed ? Colors.blueAccent : const Color(0xFFED8F03),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(
                    state.isAnswerRevealed ? 'Next Question' : (state.style == ArenaStyle.timed ? 'Submit & Continue' : 'Check Answer'),
                    style: GoogleFonts.outfit(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }



  Widget _buildLobbyScreen() {
    final theme = ref.watch(themeControllerProvider);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.surfaceColor.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.shield, size: 80, color: Color(0xFFED8F03)),
            ),
            const SizedBox(height: 32),
            Text(
              'Welcome to the Arena',
              style: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.bold, color: theme.textColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Select your challenge source, adjust your timer settings, and pick the question types before entering the battlefield.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: theme.textColor.withValues(alpha: 0.7), fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 48),
            ElevatedButton.icon(
              icon: const Icon(Icons.settings, color: Colors.white),
              label: const Text('Configure Match', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const ArenaSettingsDialog(),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFED8F03),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                elevation: 10,
                shadowColor: const Color(0xFFED8F03).withValues(alpha: 0.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
