// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'practice_questions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PracticeQuestions _$PracticeQuestionsFromJson(Map<String, dynamic> json) =>
    _PracticeQuestions(
      textCompletions:
          json['text_completions'] == null
              ? null
              : TextCompletions.fromJson(
                json['text_completions'] as Map<String, dynamic>,
              ),
      sentenceEquivalence:
          json['sentence_equivalence'] == null
              ? null
              : SentenceEquivalence.fromJson(
                json['sentence_equivalence'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$PracticeQuestionsToJson(_PracticeQuestions instance) =>
    <String, dynamic>{
      'text_completions': instance.textCompletions,
      'sentence_equivalence': instance.sentenceEquivalence,
    };

_TextCompletions _$TextCompletionsFromJson(Map<String, dynamic> json) =>
    _TextCompletions(
      oneBlank:
          json['one_blank'] == null
              ? null
              : TextCompletionQuestion.fromJson(
                json['one_blank'] as Map<String, dynamic>,
              ),
      twoBlanks:
          json['two_blanks'] == null
              ? null
              : TextCompletionQuestion.fromJson(
                json['two_blanks'] as Map<String, dynamic>,
              ),
      threeBlanks:
          json['three_blanks'] == null
              ? null
              : TextCompletionQuestion.fromJson(
                json['three_blanks'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$TextCompletionsToJson(_TextCompletions instance) =>
    <String, dynamic>{
      'one_blank': instance.oneBlank,
      'two_blanks': instance.twoBlanks,
      'three_blanks': instance.threeBlanks,
    };

_TextCompletionQuestion _$TextCompletionQuestionFromJson(
  Map<String, dynamic> json,
) => _TextCompletionQuestion(
  questionText: json['question_text'] as String,
  blanks:
      (json['blanks'] as List<dynamic>)
          .map((e) => QuestionBlank.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$TextCompletionQuestionToJson(
  _TextCompletionQuestion instance,
) => <String, dynamic>{
  'question_text': instance.questionText,
  'blanks': instance.blanks,
};

_QuestionBlank _$QuestionBlankFromJson(Map<String, dynamic> json) =>
    _QuestionBlank(
      correctAnswer: json['correct_answer'] as String,
      distractors:
          (json['distractors'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
    );

Map<String, dynamic> _$QuestionBlankToJson(_QuestionBlank instance) =>
    <String, dynamic>{
      'correct_answer': instance.correctAnswer,
      'distractors': instance.distractors,
    };

_SentenceEquivalence _$SentenceEquivalenceFromJson(Map<String, dynamic> json) =>
    _SentenceEquivalence(
      questionText: json['question_text'] as String,
      correctAnswers:
          (json['correct_answers'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      distractors:
          (json['distractors'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
    );

Map<String, dynamic> _$SentenceEquivalenceToJson(
  _SentenceEquivalence instance,
) => <String, dynamic>{
  'question_text': instance.questionText,
  'correct_answers': instance.correctAnswers,
  'distractors': instance.distractors,
};
