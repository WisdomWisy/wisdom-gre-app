import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisdom_gre_app/features/vocabulary/data/models/gre_word.dart';
import 'package:wisdom_gre_app/features/arena/data/models/quiz_question.dart';

class GameState {
  final List<QuizQuestion> questions;
  final int currentIndex;
  final int score;
  final bool isAnswered;
  final String? selectedAnswer;
  final bool isFinished;

  GameState({
    this.questions = const [],
    this.currentIndex = 0,
    this.score = 0,
    this.isAnswered = false,
    this.selectedAnswer,
    this.isFinished = false,
  });

  GameState copyWith({
    List<QuizQuestion>? questions,
    int? currentIndex,
    int? score,
    bool? isAnswered,
    String? selectedAnswer,
    bool? isFinished,
  }) {
    return GameState(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      score: score ?? this.score,
      isAnswered: isAnswered ?? this.isAnswered,
      selectedAnswer: isAnswered == false ? null : (selectedAnswer ?? this.selectedAnswer), // Allow nulling selectedAnswer explicitly when resetting isAnswered
      isFinished: isFinished ?? this.isFinished,
    );
  }
}

class GameEngineNotifier extends StateNotifier<GameState> {
  GameEngineNotifier() : super(GameState());

  final _random = Random();

  void startNewGame(List<GreWord> vocabulary) {
    if (vocabulary.isEmpty) return;

    final List<QuizQuestion> sessionQuestions = [];
    final pool = List<GreWord>.from(vocabulary)..shuffle(_random);
    final targetCount = min(10, pool.length);

    for (int i = 0; i < targetCount; i++) {
      final targetWord = pool[i];
      final type = QuestionType.values[_random.nextInt(QuestionType.values.length)];

      List<GreWord> distractors = vocabulary
          .where((w) => w.word != targetWord.word && w.difficulty == targetWord.difficulty)
          .toList()
        ..shuffle(_random);

      if (distractors.length < 3) {
        // Fallback: take random words if difficulty pool is too small
        final additional = vocabulary.where((w) => w.word != targetWord.word && !distractors.contains(w)).toList()..shuffle(_random);
        distractors.addAll(additional.take(3 - distractors.length));
      }

      final chosenDistractors = distractors.take(3).toList();
      
      String questionText = '';
      String correctAnswer = '';
      List<String> options = [];

      switch (type) {
        case QuestionType.findWord:
          questionText = targetWord.definitionEn;
          correctAnswer = targetWord.word;
          options = [targetWord.word, ...chosenDistractors.map((e) => e.word)];
          break;
        case QuestionType.findDefinition:
          questionText = targetWord.word;
          correctAnswer = targetWord.definitionEn;
          options = [targetWord.definitionEn, ...chosenDistractors.map((e) => e.definitionEn)];
          break;
        case QuestionType.fillInBlank:
          String sentence = '';
          if (targetWord.greContextSentences.isNotEmpty) {
            sentence = targetWord.greContextSentences[_random.nextInt(targetWord.greContextSentences.length)];
          } else {
            // Fallback to findWord if no sentences available
            questionText = targetWord.definitionEn;
            correctAnswer = targetWord.word;
            options = [targetWord.word, ...chosenDistractors.map((e) => e.word)];
            sessionQuestions.add(QuizQuestion(type: QuestionType.findWord, questionText: questionText, correctAnswer: correctAnswer, options: options..shuffle(_random)));
            continue;
          }

          // Smart Masking using word root regex (to catch inflections like 'abated').
          // We take the first 4 letters (or less) to form the stem.
          final stemLength = min(5, targetWord.word.length);
          final stem = targetWord.word.substring(0, stemLength);
          
          // Regex breakdown: \b matches word boundary. 
          // Stem is matched (case insensitive). \w* matches the rest of the word. \b matches end of word.
          final regex = RegExp(r'\b' + RegExp.escape(stem) + r'\w*\b', caseSensitive: false);
          
          if (regex.hasMatch(sentence)) {
             questionText = sentence.replaceAll(regex, '________');
          } else {
             // Absolute fallback if the stem regex fails to find the word in the sentence
             // Just do a simple replace or fallback to findWord
             final simpleRegex = RegExp(r'\b' + RegExp.escape(targetWord.word) + r'\w*\b', caseSensitive: false);
             if (simpleRegex.hasMatch(sentence)) {
                 questionText = sentence.replaceAll(simpleRegex, '________');
             } else {
                 // The sentence might not contain the word explicitly in easily detectable forms
                 // Fallback to findWord type
                 sessionQuestions.add(QuizQuestion(
                   type: QuestionType.findWord, 
                   questionText: targetWord.definitionEn, 
                   correctAnswer: targetWord.word, 
                   options: [targetWord.word, ...chosenDistractors.map((e) => e.word)]..shuffle(_random)
                 ));
                 continue;
             }
          }
          
          correctAnswer = targetWord.word;
          options = [targetWord.word, ...chosenDistractors.map((e) => e.word)];
          break;
      }

      options.shuffle(_random);
      
      sessionQuestions.add(QuizQuestion(
        type: type,
        questionText: questionText,
        correctAnswer: correctAnswer,
        options: options,
      ));
    }

    state = GameState(questions: sessionQuestions);
  }

  void submitAnswer(String answer) {
    if (state.isAnswered || state.isFinished || state.questions.isEmpty) return;

    final currentQ = state.questions[state.currentIndex];
    final isCorrect = answer == currentQ.correctAnswer;
    final newScore = isCorrect ? state.score + 1 : state.score;

    state = state.copyWith(
      isAnswered: true,
      selectedAnswer: answer,
      score: newScore,
    );
  }

  void nextQuestion() {
    if (!state.isAnswered || state.isFinished) return;

    if (state.currentIndex < state.questions.length - 1) {
      state = state.copyWith(
        currentIndex: state.currentIndex + 1,
        isAnswered: false,
        selectedAnswer: null,
      );
    } else {
      state = state.copyWith(isFinished: true);
    }
  }
}

final gameEngineProvider = StateNotifierProvider<GameEngineNotifier, GameState>((ref) {
  return GameEngineNotifier();
});
