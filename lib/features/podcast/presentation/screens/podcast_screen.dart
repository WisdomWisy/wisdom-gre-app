import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisdom_gre_app/core/components/mesh_background.dart';
import 'package:wisdom_gre_app/core/components/settings_dialog.dart';
import 'package:wisdom_gre_app/core/theme/app_theme.dart';
import 'package:wisdom_gre_app/features/podcast/data/models/podcast_state.dart';
import 'package:wisdom_gre_app/features/podcast/domain/podcast_controller.dart';

/// Podcast screen — NO AnimationController / Ticker.
///
/// We deliberately avoid AnimationControllers here because even a single
/// repeat() ticker running at 60 fps on the same Dart isolate can delay
/// platform-channel callbacks from flutter_tts, causing awaitSpeakCompletion
/// to mis-fire on Android.
///
/// All visual effects use implicit animations (AnimatedContainer,
/// AnimatedSwitcher, AnimatedOpacity) which only fire when values change —
/// zero continuous frames, zero TTS interference.
class PodcastScreen extends ConsumerStatefulWidget {
  const PodcastScreen({super.key});

  @override
  ConsumerState<PodcastScreen> createState() => _PodcastScreenState();
}

class _PodcastScreenState extends ConsumerState<PodcastScreen> {
  @override
  void initState() {
    super.initState();
    // Load queue only if not already loaded — guards against re-init
    // when the user navigates back from Settings or Dashboard.
    Future.microtask(() {
      final s = ref.read(podcastControllerProvider);
      if (s.queue.isEmpty && !s.isLoading) {
        ref
            .read(podcastControllerProvider.notifier)
            .loadQueue(PodcastSourceMode.reviewSession);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeControllerProvider);
    final state = ref.watch(podcastControllerProvider);
    final ctrl = ref.read(podcastControllerProvider.notifier);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appBar(theme, state, ctrl),
      body: MeshBackground(child: _body(theme, state, ctrl)),
    );
  }

  PreferredSizeWidget _appBar(
    AppThemeData theme,
    PodcastState state,
    PodcastController ctrl,
  ) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: theme.textColor),
      centerTitle: true,
      title: Text(
        'Podcast Mode',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
          color: theme.textColor,
        ),
      ),
      actions: [
        IconButton(
          tooltip: 'Settings',
          icon: Icon(Icons.tune_rounded, color: theme.textColor),
          onPressed: () => showDialog(
            context: context,
            builder: (_) => const SettingsDialog(),
          ),
        ),
        _SourceChip(
          isReview: state.sourceMode == PodcastSourceMode.reviewSession,
          textColor: theme.textColor,
          onTap: ctrl.switchSourceMode,
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  Widget _body(
    AppThemeData theme,
    PodcastState state,
    PodcastController ctrl,
  ) {
    if (state.isLoading) {
      return Center(child: CircularProgressIndicator(color: theme.textColor));
    }
    if (state.error.isNotEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(state.error,
              textAlign: TextAlign.center,
              style: TextStyle(color: theme.textColor, height: 1.5)),
        ),
      );
    }
    if (state.queue.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            state.sourceMode == PodcastSourceMode.reviewSession
                ? 'No words to review today! 🎉\nSwitch to "All" to keep listening.'
                : 'Vocabulary database is empty.',
            textAlign: TextAlign.center,
            style: TextStyle(color: theme.textColor, fontSize: 18, height: 1.6),
          ),
        ),
      );
    }

    final word = state.currentWord!;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // ── Album art — implicit glow changes with isPlaying ──
            _AlbumArt(
              letter: word.word[0].toUpperCase(),
              isPlaying: state.isPlaying,
              theme: theme,
            ),

            const SizedBox(height: 32),

            // ── Word — AnimatedSwitcher on word change ────────────
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              child: Text(
                word.word,
                key: ValueKey(word.word),
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  color: theme.textColor,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 20),

            // ── Lyrics / subtitle card ────────────────────────────
            _LyricsCard(theme: theme, state: state),

            const SizedBox(height: 20),

            // ── Progress ──────────────────────────────────────────
            _ProgressRow(theme: theme, state: state),

            const Spacer(),

            // ── Transport controls ────────────────────────────────
            _Controls(theme: theme, state: state, ctrl: ctrl),

            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Album Art  — glow pulses via AnimatedContainer (implicit, no ticker)
// ─────────────────────────────────────────────────────────────────────────────

class _AlbumArt extends StatelessWidget {
  const _AlbumArt({
    required this.letter,
    required this.isPlaying,
    required this.theme,
  });

  final String letter;
  final bool isPlaying;
  final AppThemeData theme;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      width: isPlaying ? 220 : 200,
      height: isPlaying ? 220 : 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            theme.textColor.withValues(alpha: 0.1),
            theme.textColor.withValues(alpha: 0.65),
            theme.textColor.withValues(alpha: 0.92),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: theme.textColor
                .withValues(alpha: isPlaying ? 0.4 : 0.15),
            blurRadius: isPlaying ? 50 : 20,
            spreadRadius: isPlaying ? 6 : 0,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Groove rings
          for (final r in [0.62, 0.76, 0.87])
            SizedBox(
              width: (isPlaying ? 220 : 200) * r,
              height: (isPlaying ? 220 : 200) * r,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.surfaceColor.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
              ),
            ),
          // Centre label
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.surfaceColor.withValues(alpha: 0.9),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  letter,
                  key: ValueKey(letter),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: theme.textColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Lyrics Card
// ─────────────────────────────────────────────────────────────────────────────

class _LyricsCard extends StatelessWidget {
  const _LyricsCard({required this.theme, required this.state});

  final AppThemeData theme;
  final PodcastState state;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 110),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: theme.textColor.withValues(
            alpha: state.isPlaying ? 0.09 : 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.textColor.withValues(alpha: 0.14),
        ),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: state.isPlaying
            ? Column(
                key: ValueKey(state.currentlySpeakingText),
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 3),
                    decoration: BoxDecoration(
                      color: theme.textColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      state.currentlySpeakingTitle.toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: theme.textColor.withValues(alpha: 0.55),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    state.currentlySpeakingText,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: theme.textColor.withValues(alpha: 0.9),
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            : Row(
                key: const ValueKey('paused'),
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.pause_circle_outline_rounded,
                      color: theme.textColor.withValues(alpha: 0.3),
                      size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Paused',
                    style: TextStyle(
                        fontSize: 16,
                        color: theme.textColor.withValues(alpha: 0.3)),
                  ),
                ],
              ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Progress Row
// ─────────────────────────────────────────────────────────────────────────────

class _ProgressRow extends StatelessWidget {
  const _ProgressRow({required this.theme, required this.state});

  final AppThemeData theme;
  final PodcastState state;

  @override
  Widget build(BuildContext context) {
    final progress = state.queue.isEmpty
        ? 0.0
        : (state.currentIndex + 1) / state.queue.length;

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 5,
            backgroundColor: theme.textColor.withValues(alpha: 0.1),
            valueColor: AlwaysStoppedAnimation<Color>(
                theme.textColor.withValues(alpha: 0.75)),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Word ${state.currentIndex + 1}',
                style: TextStyle(
                    fontSize: 12,
                    color: theme.textColor.withValues(alpha: 0.4))),
            Text('${state.queue.length} total',
                style: TextStyle(
                    fontSize: 12,
                    color: theme.textColor.withValues(alpha: 0.4))),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Controls
// ─────────────────────────────────────────────────────────────────────────────

class _Controls extends StatelessWidget {
  const _Controls({
    required this.theme,
    required this.state,
    required this.ctrl,
  });

  final AppThemeData theme;
  final PodcastState state;
  final PodcastController ctrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          iconSize: 38,
          icon: const Icon(Icons.skip_previous_rounded),
          color: state.currentIndex > 0
              ? theme.textColor
              : theme.textColor.withValues(alpha: 0.25),
          onPressed: state.currentIndex > 0 ? ctrl.previous : null,
        ),
        _PlayPauseButton(
          isPlaying: state.isPlaying,
          theme: theme,
          onTap: state.isPlaying ? ctrl.pause : ctrl.play,
        ),
        IconButton(
          iconSize: 38,
          icon: const Icon(Icons.skip_next_rounded),
          color: state.currentIndex < state.queue.length - 1
              ? theme.textColor
              : theme.textColor.withValues(alpha: 0.25),
          onPressed: state.currentIndex < state.queue.length - 1
              ? ctrl.next
              : null,
        ),
      ],
    );
  }
}

class _PlayPauseButton extends StatelessWidget {
  const _PlayPauseButton({
    required this.isPlaying,
    required this.theme,
    required this.onTap,
  });

  final bool isPlaying;
  final AppThemeData theme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: theme.textColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: theme.textColor
                  .withValues(alpha: isPlaying ? 0.45 : 0.2),
              blurRadius: isPlaying ? 30 : 12,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Icon(
            isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
            key: ValueKey(isPlaying),
            size: 46,
            color: theme.surfaceColor,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Source chip (Review / All)
// ─────────────────────────────────────────────────────────────────────────────

class _SourceChip extends StatelessWidget {
  const _SourceChip({
    required this.isReview,
    required this.textColor,
    required this.onTap,
  });

  final bool isReview;
  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: textColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: textColor.withValues(alpha: 0.25)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isReview
                    ? Icons.assignment_rounded
                    : Icons.all_inclusive_rounded,
                size: 15,
                color: textColor,
              ),
              const SizedBox(width: 5),
              Text(
                isReview ? 'Review' : 'All',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
