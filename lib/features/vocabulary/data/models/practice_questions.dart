import 'package:freezed_annotation/freezed_annotation.dart';

part 'practice_questions.freezed.dart';
part 'practice_questions.g.dart';

@freezed
abstract class PracticeQuestions with _$PracticeQuestions {
  const factory PracticeQuestions({
    @JsonKey(name: 'text_completions') TextCompletions? textCompletions,
    @JsonKey(name: 'sentence_equivalence') SentenceEquivalence? sentenceEquivalence,
  }) = _PracticeQuestions;

  factory PracticeQuestions.fromJson(Map<String, dynamic> json) => _$PracticeQuestionsFromJson(json);
}

@freezed
abstract class TextCompletions with _$TextCompletions {
  const factory TextCompletions({
    @JsonKey(name: 'one_blank') TextCompletionQuestion? oneBlank,
    @JsonKey(name: 'two_blanks') TextCompletionQuestion? twoBlanks,
    @JsonKey(name: 'three_blanks') TextCompletionQuestion? threeBlanks,
  }) = _TextCompletions;

  factory TextCompletions.fromJson(Map<String, dynamic> json) => _$TextCompletionsFromJson(json);
}

@freezed
abstract class TextCompletionQuestion with _$TextCompletionQuestion {
  const factory TextCompletionQuestion({
    @JsonKey(name: 'question_text') required String questionText,
    required List<QuestionBlank> blanks,
  }) = _TextCompletionQuestion;

  factory TextCompletionQuestion.fromJson(Map<String, dynamic> json) => _$TextCompletionQuestionFromJson(json);
}

@freezed
abstract class QuestionBlank with _$QuestionBlank {
  const factory QuestionBlank({
    @JsonKey(name: 'correct_answer') required String correctAnswer,
    required List<String> distractors,
  }) = _QuestionBlank;

  factory QuestionBlank.fromJson(Map<String, dynamic> json) => _$QuestionBlankFromJson(json);
}

@freezed
abstract class SentenceEquivalence with _$SentenceEquivalence {
  const factory SentenceEquivalence({
    @JsonKey(name: 'question_text') required String questionText,
    @JsonKey(name: 'correct_answers') required List<String> correctAnswers,
    required List<String> distractors,
  }) = _SentenceEquivalence;

  factory SentenceEquivalence.fromJson(Map<String, dynamic> json) => _$SentenceEquivalenceFromJson(json);
}
