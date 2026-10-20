import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
class QuizProgress extends StatelessWidget {
  final int currentQuestion;
  final int totalQuestions;
  const QuizProgress({
    super.key,
    required this.currentQuestion,
    required this.totalQuestions,
  });
  @override
  Widget build(BuildContext context) {
    final progress = totalQuestions == 0
        ? 0.0
        : currentQuestion / totalQuestions;
    final percentage = (progress * 100).round();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'progres kuis',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.darkBrown,
              ),
            ),
            Text(
              '$percentage%',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: AppTheme.lightBrown,
            color: AppTheme.primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'pertanyaan $currentQuestion dari $totalQuestions',
          textAlign: TextAlign.end,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.primaryColor,
          ),
        ),
      ],
    );
  }
}