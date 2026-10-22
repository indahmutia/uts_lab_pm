import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../theme/app_theme.dart';
import 'discussion_screen.dart';
import 'login_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

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
          style: TextStyle(
            color: AppTheme.primaryColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
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

    final int score = quiz.score;
    final int totalQuestions = quiz.totalQuestions;
    final int wrongAnswers = totalQuestions - score;

    final double percentage = totalQuestions == 0
        ? 0
        : (score / totalQuestions) * 100;

    final String category = quiz.selectedCategory;
    final String userName = quiz.userName.trim().isEmpty
        ? 'Teman'
        : quiz.userName.trim();

    String message;
    IconData resultIcon;

    if (percentage >= 80) {
      message = 'Hebat banget! Kamu menguasai materi ini!';
      resultIcon = Icons.emoji_events_rounded;
    } else if (percentage >= 60) {
      message = 'Bagus! Terus latihan agar hasilmu makin baik.';
      resultIcon = Icons.workspace_premium_rounded;
    } else {
      message =
      'Jangan menyerah! Yuk, coba lagi dan pelajari materinya.';
      resultIcon = Icons.menu_book_rounded;
    }

    return Scaffold(
      appBar: AppBar(
        // Tombol panah kembali di kiri atas.
        leading: IconButton(
          tooltip: 'Kembali',
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Hasil Kuis',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          // Tombol logout tetap di kanan atas.
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(22),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 480,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),

                  // Ikon hasil kuis.
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppTheme.lightBrown,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        resultIcon,
                        size: 56,
                        color: AppTheme.darkBrown,
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  const Text(
                    'Kuis Selesai!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkBrown,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Kerja bagus, $userName!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppTheme.primaryColor,
                    ),
                  ),

                  const SizedBox(height: 26),

                  // Kartu hasil kuis.
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppTheme.cardColor,
                      borderRadius: BorderRadius.circular(26),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.darkBrown.withValues(
                            alpha: 0.08,
                          ),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Kategori Kuis',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppTheme.primaryColor,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          category.isEmpty
                              ? 'Semua Kategori'
                              : category,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.darkBrown,
                          ),
                        ),

                        const SizedBox(height: 22),

                        // Nilai dalam bentuk lingkaran.
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.lightBrown.withValues(
                              alpha: 0.45,
                            ),
                            border: Border.all(
                              color: AppTheme.primaryColor,
                              width: 5,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${percentage.round()}%',
                                style: const TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.darkBrown,
                                ),
                              ),
                              const Text(
                                'Nilai Kamu',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Jumlah jawaban benar, salah, dan total.
                        Row(
                          children: [
                            Expanded(
                              child: _ScoreItem(
                                icon: Icons.check_circle_rounded,
                                label: 'Benar',
                                value: '$score',
                                color: Colors.green.shade700,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _ScoreItem(
                                icon: Icons.cancel_rounded,
                                label: 'Salah',
                                value: '$wrongAnswers',
                                color: Colors.red.shade700,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _ScoreItem(
                                icon: Icons.quiz_rounded,
                                label: 'Total',
                                value: '$totalQuestions',
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 22),

                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: AppTheme.darkBrown,
                    ),
                  ),

                  const SizedBox(height: 26),

                  // Hanya tombol Lihat Pembahasan.
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DiscussionScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.menu_book_rounded),
                    label: const Text('Lihat Pembahasan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(
                        double.infinity,
                        54,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ScoreItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _ScoreItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 23,
          ),
          const SizedBox(height: 7),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}