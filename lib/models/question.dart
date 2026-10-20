class Question {
  final int id;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String category;

  const Question({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.category,
  });
}