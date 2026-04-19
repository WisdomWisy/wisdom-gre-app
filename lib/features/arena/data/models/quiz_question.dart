enum QuestionType { findWord, findDefinition, fillInBlank }

class QuizQuestion {
  final QuestionType type;
  final String questionText;
  final String correctAnswer;
  final List<String> options;

  QuizQuestion({
    required this.type,
    required this.questionText,
    required this.correctAnswer,
    required this.options,
  });
}
