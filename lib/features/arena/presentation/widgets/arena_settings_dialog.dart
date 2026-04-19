import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisdom_gre_app/core/theme/app_theme.dart';
import 'package:wisdom_gre_app/features/arena/presentation/providers/arena_state.dart';
import 'package:wisdom_gre_app/features/arena/presentation/providers/arena_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class ArenaSettingsDialog extends ConsumerStatefulWidget {
  const ArenaSettingsDialog({super.key});

  @override
  ConsumerState<ArenaSettingsDialog> createState() => _ArenaSettingsDialogState();
}

class _ArenaSettingsDialogState extends ConsumerState<ArenaSettingsDialog> {
  late ArenaMode _localMode;
  late ArenaStyle _localStyle;
  late double _localCount;
  late bool _includeTC;
  late bool _includeSE;

  @override
  void initState() {
    super.initState();
    final state = ref.read(arenaControllerProvider);
    _localMode = state.mode;
    _localStyle = state.style;
    _localCount = state.customQuestionCount.toDouble();
    _includeTC = state.includeTextCompletion;
    _includeSE = state.includeSentenceEquivalence;
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeControllerProvider);

    return AlertDialog(
      backgroundColor: theme.surfaceColor.withValues(alpha: 0.95),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text('Arena Configuration', style: GoogleFonts.outfit(color: theme.textColor, fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Mode Selection
            Text(
              'CHALLENGE SOURCE',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: theme.textColor.withValues(alpha: 0.4)),
            ),
            const SizedBox(height: 8),
            SegmentedButton<ArenaMode>(
              style: SegmentedButton.styleFrom(
                backgroundColor: Colors.transparent,
                selectedForegroundColor: Colors.white,
                selectedBackgroundColor: const Color(0xFFED8F03),
                foregroundColor: theme.textColor,
                side: BorderSide(color: theme.textColor.withValues(alpha: 0.1)),
              ),
              segments: const [
                ButtonSegment(value: ArenaMode.dailyFocus, label: Text('Daily', style: TextStyle(fontSize: 12))),
                ButtonSegment(value: ArenaMode.marathon, label: Text('Marathon', style: TextStyle(fontSize: 12))),
              ],
              selected: {_localMode},
              onSelectionChanged: (set) => setState(() => _localMode = set.first),
            ),
            const SizedBox(height: 16),

            // Number of questions
            Text(
              'NUMBER OF QUESTIONS: ${_localCount.toInt()}',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: theme.textColor.withValues(alpha: 0.4)),
            ),
            Slider(
              value: _localCount,
              min: 5,
              max: 50,
              divisions: 9,
              activeColor: const Color(0xFFED8F03),
              inactiveColor: theme.textColor.withValues(alpha: 0.1),
              onChanged: (val) => setState(() => _localCount = val),
            ),
            const SizedBox(height: 16),

            // Style Selection
            Text(
              'LEARNING STYLE',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: theme.textColor.withValues(alpha: 0.4)),
            ),
            const SizedBox(height: 8),
            SegmentedButton<ArenaStyle>(
              style: SegmentedButton.styleFrom(
                backgroundColor: Colors.transparent,
                selectedForegroundColor: Colors.white,
                selectedBackgroundColor: const Color(0xFFED8F03),
                foregroundColor: theme.textColor,
                side: BorderSide(color: theme.textColor.withValues(alpha: 0.1)),
              ),
              segments: const [
                ButtonSegment(value: ArenaStyle.learning, label: Text('Learning', style: TextStyle(fontSize: 12))),
                ButtonSegment(value: ArenaStyle.timed, label: Text('Timed', style: TextStyle(fontSize: 12))),
              ],
              selected: {_localStyle},
              onSelectionChanged: (set) => setState(() => _localStyle = set.first),
            ),
            const SizedBox(height: 16),

            // Question Type Selection
            Text(
              'QUESTION TYPES',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: theme.textColor.withValues(alpha: 0.4)),
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: const Color(0xFFED8F03),
              title: Text('Text Completion', style: TextStyle(color: theme.textColor, fontSize: 14)),
              value: _includeTC,
              onChanged: (val) {
                if (val != null) {
                  // Prevent unchecking both
                  if (!val && !_includeSE) return;
                  setState(() => _includeTC = val);
                }
              },
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: const Color(0xFFED8F03),
              title: Text('Sentence Equivalence', style: TextStyle(color: theme.textColor, fontSize: 14)),
              value: _includeSE,
              onChanged: (val) {
                if (val != null) {
                  // Prevent unchecking both
                  if (!val && !_includeTC) return;
                  setState(() => _includeSE = val);
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel', style: TextStyle(color: theme.textColor.withValues(alpha: 0.6))),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFED8F03),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {
            ref.read(arenaControllerProvider.notifier).setMode(
              _localMode, 
              _localStyle, 
              _localCount.toInt(), 
              includeTC: _includeTC, 
              includeSE: _includeSE
            );
            Navigator.of(context).pop();
          },
          child: const Text('Start', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
