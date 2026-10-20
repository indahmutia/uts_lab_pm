import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
class QuestionsCard extends StatelessWidget {
  final int questionNumber;
  final int totalQuestions;
  final String category;
  final String question;
  const QuestionsCard({
    super.key,
    required this.questionNumber,
    required this.totalQuestions,
    required this.category,
    required this.question,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppTheme.lightBrown),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'PERTANYAAN',
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
              Text(
                '$questionNumber/$totalQuestions',
                style: const TextStyle(
                  color: AppTheme.darkBrown,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: AppTheme.lightBrown.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              category,
              style: const TextStyle(
                color: AppTheme.primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            question,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w700,
              color: AppTheme.darkBrown,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'pilih satu jawaban yang paling tepat.',
            style: TextStyle(
              color: AppTheme.primaryColor,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}