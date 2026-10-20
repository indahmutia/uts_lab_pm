import 'package:flutter/foundation.dart';
import '../data/quiz_questions.dart';

class QuizProvider extends ChangeNotifier {
  String userName = '';
  String selectedCategory = '';
  int currentQuestionIndex = 0;

  // Menyimpan jawaban berdasarkan indeks soal di quizQuestions.
  final Map<int, int> selectedAnswers = {};

  // Mengambil soal berdasarkan kategori yang dipilih.
  List<dynamic> get currentQuestions {
    if (selectedCategory.isEmpty) {
      return quizQuestions;
    }

    return quizQuestions
        .where(
          (question) =>
      question.category.toLowerCase() ==
          selectedCategory.toLowerCase(),
    )
        .toList();
  }

  int get totalQuestions => currentQuestions.length;

  int get progressPercent {
    if (totalQuestions == 0) return 0;

    return (((currentQuestionIndex + 1) / totalQuestions) * 100).round();
  }

  // Menghitung jawaban benar untuk kategori yang sedang dikerjakan.
  int get score {
    int totalScore = 0;

    selectedAnswers.forEach((questionIndex, answerIndex) {
      if (questionIndex < 0 || questionIndex >= quizQuestions.length) {
        return;
      }

      final question = quizQuestions[questionIndex];

      final isSameCategory = selectedCategory.isEmpty ||
          question.category.toLowerCase() ==
              selectedCategory.toLowerCase();

      if (isSameCategory &&
          question.correctAnswerIndex == answerIndex) {
        totalScore++;
      }
    });

    return totalScore;
  }

  void startQuiz(String name, {String? category}) {
    userName = name.trim();
    selectedCategory = category ?? '';
    currentQuestionIndex = 0;
    selectedAnswers.clear();
    notifyListeners();
  }

  // questionIndex adalah indeks soal di daftar quizQuestions.
  void selectAnswer(int answerIndex, {int? questionIndex}) {
    final actualIndex = questionIndex ?? currentQuestionIndex;

    if (actualIndex < 0 || actualIndex >= quizQuestions.length) {
      return;
    }

    final question = quizQuestions[actualIndex];

    if (selectedCategory.isNotEmpty &&
        question.category.toLowerCase() !=
            selectedCategory.toLowerCase()) {
      return;
    }

    if (answerIndex < 0 ||
        answerIndex >= question.options.length) {
      return;
    }

    selectedAnswers[actualIndex] = answerIndex;
    notifyListeners();
  }

  void nextQuestion() {
    if (currentQuestionIndex < totalQuestions - 1) {
      currentQuestionIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      currentQuestionIndex--;
      notifyListeners();
    }
  }

  void resetQuiz() {
    userName = '';
    selectedCategory = '';
    currentQuestionIndex = 0;
    selectedAnswers.clear();
    notifyListeners();
  }
}