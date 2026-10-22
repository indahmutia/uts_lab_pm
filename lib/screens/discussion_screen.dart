import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/quiz_questions.dart';
import '../providers/quiz_provider.dart';
import '../theme/app_theme.dart';
import 'category_screen.dart';
import 'login_screen.dart';
import 'quiz_screen.dart';

class DiscussionScreen extends StatelessWidget {
  const DiscussionScreen({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppTheme.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Log Out?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppTheme.darkBrown,
          ),
        ),
        content: const Text(
          'Yakin ingin keluar dari QuizPM?',
          style: TextStyle(color: AppTheme.primaryColor),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(dialogContext);

              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => const LoginScreen(),
                ),
                    (route) => false,
              );
            },
            icon: const Icon(Icons.logout_rounded),
            label: const Text('Ya, Keluar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final questions = quiz.currentQuestions;

    final String category = quiz.selectedCategory;
    final String name = quiz.userName;
    final int total = questions.length;
    final int score = quiz.score;

    return Scaffold(
      appBar: AppBar(
        // Tombol panah untuk kembali ke halaman hasil.
        leading: IconButton(
          tooltip: 'Kembali ke Hasil Kuis',
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Pembahasan Kuis',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // Tombol logout di kanan atas.
          IconButton(
            tooltip: 'Log Out',
            onPressed: () => _showLogoutDialog(context),
            icon: const Icon(Icons.logout_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // Ringkasan hasil.
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppTheme.cardColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.isEmpty
                            ? 'Semua Kategori'
                            : category,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkBrown,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Jawaban benar: $score dari $total soal',
                        style: const TextStyle(
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Rincian setiap pertanyaan.
                ...List.generate(total, (index) {
                  final question = questions[index];

                  // Cari posisi soal dalam daftar utama.
                  final int globalIndex =
                  quizQuestions.indexOf(question);

                  final int? selectedIndex =
                  quiz.selectedAnswers[globalIndex];

                  final int correctIndex =
                      question.correctAnswerIndex;

                  final bool hasAnswered = selectedIndex != null;
                  final bool isCorrect =
                      hasAnswered && selectedIndex == correctIndex;

                  final String selectedAnswer = hasAnswered
                      ? question.options[selectedIndex].toString()
                      : 'Belum dijawab';

                  final String correctAnswer =
                  question.options[correctIndex].toString();

                  final Color statusColor = !hasAnswered
                      ? Colors.orange.shade700
                      : isCorrect
                      ? Colors.green.shade700
                      : Colors.red.shade700;

                  final IconData statusIcon = !hasAnswered
                      ? Icons.help_outline_rounded
                      : isCorrect
                      ? Icons.check_circle_rounded
                      : Icons.cancel_rounded;

                  final String statusLabel = !hasAnswered
                      ? 'Belum dijawab'
                      : isCorrect
                      ? 'Benar'
                      : 'Salah';

                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.cardColor,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: statusColor.withValues(alpha: 0.35),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppTheme.lightBrown,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.darkBrown,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                question.question.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: AppTheme.darkBrown,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Icon(
                              statusIcon,
                              color: statusColor,
                              size: 22,
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.10),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            statusLabel,
                            style: TextStyle(
                              color: statusColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        const Text(
                          'Jawaban kamu:',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          selectedAnswer,
                          style: const TextStyle(
                            color: AppTheme.darkBrown,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        if (!isCorrect) ...[
                          const SizedBox(height: 10),
                          const Text(
                            'Jawaban yang benar:',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            correctAnswer,
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                }),

                const SizedBox(height: 8),

                // Ulangi kuis dengan kategori yang sama.
                ElevatedButton.icon(
                  onPressed: total == 0
                      ? null
                      : () {
                    quiz.startQuiz(
                      name,
                      category: category,
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QuizScreen(
                          category: category,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Ulangi Kuis'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 52),
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Memilih kategori lain.
                OutlinedButton.icon(
                  onPressed: () {
                    quiz.startQuiz(name);

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CategoryScreen(),
                      ),
                          (route) => route.isFirst,
                    );
                  },
                  icon: const Icon(Icons.category_rounded),
                  label: const Text('Pilih Kategori Lain'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primaryColor,
                    minimumSize: const Size(double.infinity, 52),
                    side: const BorderSide(
                      color: AppTheme.primaryColor,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Kembali ke halaman awal.
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).popUntil(
                          (route) => route.isFirst,
                    );
                  },
                  icon: const Icon(Icons.home_rounded),
                  label: const Text('Kembali ke Awal'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppTheme.darkBrown,
                    minimumSize: const Size(double.infinity, 48),
                  ),
                ),

                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}