import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/quiz_questions.dart';
import '../providers/quiz_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/answer_option.dart';
import '../widgets/question_card.dart';
import '../widgets/quiz_progress.dart';
import '../widgets/primary_button.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String category;

  const QuizScreen({
    super.key,
    required this.category,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<dynamic> get filteredQuestions {
    return quizQuestions.where((question) {
      return question.category.toLowerCase() ==
          widget.category.toLowerCase();
    }).toList();
  }

  Future<void> _showExitDialog(BuildContext context) async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Keluar dari kuis?'),
          content: const Text(
            'Progres jawaban kamu akan dihapus kalau keluar sekarang.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );

    if (shouldExit == true && context.mounted) {
      context.read<QuizProvider>().resetQuiz();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final questions = filteredQuestions;

    if (questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.category),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.quiz_outlined,
                  size: 60,
                  color: AppTheme.primaryColor,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Soal untuk kategori ini belum tersedia.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: AppTheme.darkBrown,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Kembali'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Consumer<QuizProvider>(
      builder: (context, quiz, child) {
        final currentIndex = quiz.currentQuestionIndex
            .clamp(0, questions.length - 1);

        final question = questions[currentIndex];

        final selectedAnswer = quiz.selectedAnswers[
        quizQuestions.indexOf(question)
        ];

        final isLastQuestion = currentIndex == questions.length - 1;

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) {
              _showExitDialog(context);
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(widget.category),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.close_rounded),
                tooltip: 'Keluar dari kuis',
                onPressed: () => _showExitDialog(context),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Ayo kerjakan kuis, ${quiz.userName}!',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.darkBrown,
                          ),
                        ),
                        const SizedBox(height: 16),
                        QuizProgress(
                          currentQuestion: currentIndex + 1,
                          totalQuestions: questions.length,
                        ),
                        const SizedBox(height: 24),
                        QuestionsCard(
                          questionNumber: currentIndex + 1,
                          totalQuestions: questions.length,
                          category: question.category,
                          question: question.question,
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Pilihan jawaban',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.darkBrown,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...List.generate(
                          question.options.length,
                              (index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: 12,
                              ),
                              child: AnswerOption(
                                text: question.options[index],
                                optionLabel:
                                String.fromCharCode(65 + index),
                                isSelected: selectedAnswer == index,
                                onTap: () {
                                  quiz.selectAnswer(
                                    index,
                                    questionIndex:
                                    quizQuestions.indexOf(question),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: currentIndex > 0
                                    ? () {
                                  quiz.previousQuestion();
                                }
                                    : null,
                                icon: const Icon(
                                  Icons.arrow_back_rounded,
                                ),
                                label: const Text('Sebelumnya'),
                                style: OutlinedButton.styleFrom(
                                  minimumSize:
                                  const Size.fromHeight(52),
                                  foregroundColor:
                                  AppTheme.primaryColor,
                                  side: const BorderSide(
                                    color: AppTheme.primaryColor,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: PrimaryButton(
                                text: isLastQuestion
                                    ? 'Lihat hasil'
                                    : 'Selanjutnya',
                                icon: isLastQuestion
                                    ? Icons.emoji_events_rounded
                                    : Icons.arrow_forward_rounded,
                                onPressed: selectedAnswer == null
                                    ? null
                                    : () {
                                  if (isLastQuestion) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                        const ResultScreen(),
                                      ),
                                    );
                                  } else {
                                    quiz.nextQuestion();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Pilih jawaban yang paling tepat untuk '
                              'melanjutkan kuis.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: AppTheme.darkBrown.withValues(
                              alpha: 0.7,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}