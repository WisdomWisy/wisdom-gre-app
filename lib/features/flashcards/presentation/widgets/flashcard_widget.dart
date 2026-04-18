import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:wisdom_gre_app/core/theme/app_theme.dart';
import 'package:wisdom_gre_app/core/providers/language_provider.dart';
import 'package:wisdom_gre_app/features/vocabulary/data/models/gre_word.dart';
import 'package:wisdom_gre_app/features/flashcards/presentation/widgets/flip_card.dart';
import 'package:wisdom_gre_app/features/podcast/domain/podcast_controller.dart';

class FlashcardWidget extends ConsumerStatefulWidget {
  final GreWord word;
  final bool isFront;
  final VoidCallback onFlip;

  const FlashcardWidget({
    Key? key,
    required this.word,
    required this.isFront,
    required this.onFlip,
  }) : super(key: key);

  @override
  ConsumerState<FlashcardWidget> createState() => _FlashcardWidgetState();
}

class _FlashcardWidgetState extends ConsumerState<FlashcardWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _audioError = false;

  @override
  void initState() {
    super.initState();
    _playAudio();
  }

  @override
  void didUpdateWidget(FlashcardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.word != oldWidget.word) {
      _audioError = false;
      _playAudio();
    }
  }

  Future<void> _playAudio() async {
    try {
      final podcastNotifier = ref.read(podcastControllerProvider.notifier);
      final isPodcastPlaying = ref.read(podcastControllerProvider).isPlaying;
      
      if (isPodcastPlaying) {
        await podcastNotifier.pause();
      }

      // In JSON, audioFile is like "audio/abate.mp3".
      // The JSON audioFile is already 'audio/word.mp3' which matches the pubspec asset declaration.
      await _audioPlayer.setAsset(widget.word.audioFile);
      _audioPlayer.play();
    } catch (e) {
      if (mounted) {
        setState(() {
          _audioError = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedFlipCard(
      isFront: widget.isFront,
      onFlip: widget.onFlip,
      front: _buildFront(context),
      back: _buildBack(context),
    );
  }

  Widget _buildFront(BuildContext context) {
    final themeData = ref.watch(themeControllerProvider);
    
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: themeData.surfaceColor.withOpacity(0.95),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: _getDifficultyColor(widget.word.difficulty).withOpacity(0.35),
            blurRadius: 30,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.word.word,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w800,
                  color: themeData.textColor,
                  letterSpacing: -1,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                widget.word.phonetic,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: themeData.textColor.withOpacity(0.6),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 32,
            child: FloatingActionButton(
              heroTag: null,
              backgroundColor: _audioError ? Colors.grey : themeData.textColor,
              foregroundColor: themeData.surfaceColor,
              elevation: 4,
              onPressed: _audioError ? null : _playAudio,
              child: Icon(_audioError ? Icons.volume_off : Icons.volume_up_rounded),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBack(BuildContext context) {
    final themeData = ref.watch(themeControllerProvider);
    final lang = ref.watch(languageControllerProvider);
    
    final translation = lang == AppLanguage.fr 
        ? widget.word.translations.fr 
        : (lang == AppLanguage.es ? widget.word.translations.es : "Synonyms: ${widget.word.synonyms.join(', ')}");
    final mnemonic = lang == AppLanguage.fr 
        ? widget.word.mnemonics.fr 
        : (lang == AppLanguage.es ? widget.word.mnemonics.es : widget.word.mnemonics.en);
    final etymology = lang == AppLanguage.fr 
        ? widget.word.etymology.fr 
        : (lang == AppLanguage.es ? widget.word.etymology.es : widget.word.etymology.en);

    String lblDefinition = lang == AppLanguage.fr ? 'Définition' : (lang == AppLanguage.es ? 'Definición' : 'Definition');
    String lblMnemonic = lang == AppLanguage.fr ? 'Mnémonique' : (lang == AppLanguage.es ? 'Mnemotecnia' : 'Mnemonic');
    String lblContext = lang == AppLanguage.fr ? 'Contexte' : (lang == AppLanguage.es ? 'Contexto' : 'Context');
    String lblEtymology = lang == AppLanguage.fr ? 'Étymologie' : (lang == AppLanguage.es ? 'Etimología' : 'Etymology');

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: themeData.surfaceColor.withOpacity(0.95),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: _getDifficultyColor(widget.word.difficulty).withOpacity(0.35),
            blurRadius: 30,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          )
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  widget.word.word,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: themeData.textColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: themeData.textColor.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      widget.word.partOfSpeech.toUpperCase(),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: themeData.textColor.withOpacity(0.7),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getDifficultyColor(widget.word.difficulty).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _getDifficultyColor(widget.word.difficulty).withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      widget.word.difficulty.toUpperCase(),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: _getDifficultyColor(widget.word.difficulty),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            translation,
            style: TextStyle(
               fontSize: 22,
               fontWeight: FontWeight.w500,
               color: themeData.textColor.withOpacity(0.85),
               fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                   _buildSectionCard(themeData, lblDefinition, widget.word.definitionEn, Icons.menu_book_rounded),
                  const SizedBox(height: 16),
                  _buildSectionCard(themeData, lblMnemonic, mnemonic, Icons.lightbulb_outline_rounded),
                  const SizedBox(height: 16),
                  _buildSectionCard(themeData, lblContext, widget.word.greContextSentences.join('\n\n'), Icons.format_quote_rounded),
                  const SizedBox(height: 16),
                  _buildSectionCard(themeData, lblEtymology, etymology, Icons.history_edu_rounded),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(AppThemeData themeData, String title, String content, IconData icon) {
    if (content.isEmpty) return const SizedBox.shrink();
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: themeData.textColor.withOpacity(0.03),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: themeData.textColor.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: themeData.textColor.withOpacity(0.6)),
              const SizedBox(width: 8),
              Text(
                title.toUpperCase(),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                  color: themeData.textColor.withOpacity(0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: 16,
              color: themeData.textColor.withOpacity(0.95),
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy': return Colors.green;
      case 'hard': return Colors.red;
      case 'medium': 
      default: return Colors.orange;
    }
  }
}
