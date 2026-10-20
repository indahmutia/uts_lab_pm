import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../theme/app_theme.dart';
import 'quiz_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  static const List<Map<String, dynamic>> categories = [
    {
      'title': 'Flutter',
      'description': 'Pelajari widget dan komponen Flutter',
      'icon': Icons.flutter_dash,
      'color': Color(0xFFE5D5C5),
    },
    {
      'title': 'Dart',
      'description': 'Uji pemahaman bahasa pemrograman Dart',
      'icon': Icons.code_rounded,
      'color': Color(0xFFD9C5B5),
    },
    {
      'title': 'UI/UX',
      'description': 'Kenali desain dan pengalaman pengguna',
      'icon': Icons.palette_outlined,
      'color': Color(0xFFEADCCF),
    },
    {
      'title': 'Pemrograman Mobile',
      'description': 'Pelajari konsep aplikasi mobile',
      'icon': Icons.phone_android_rounded,
      'color': Color(0xFFDCC6B2),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pilih Kategori',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.menu_book_rounded,
                      color: Colors.white,
                      size: 38,
                    ),
                    SizedBox(height: 14),
                    Text(
                      'Saatnya Menguji Diri!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Pilih kategori yang ingin kamu kerjakan. '
                          'Setiap kategori memiliki 10 soal.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              const Text(
                'Kategori Kuis',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkBrown,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Semangat, ${quiz.userName.isEmpty ? 'Teman' : quiz.userName}!',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppTheme.primaryColor,
                ),
              ),
              const SizedBox(height: 16),
              ...categories.map((category) {
                return _CategoryCard(
                  title: category['title'] as String,
                  description: category['description'] as String,
                  icon: category['icon'] as IconData,
                  color: category['color'] as Color,
                  onTap: () => _startQuiz(
                    context,
                    category['title'] as String,
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _startQuiz(BuildContext context, String category) {
    final quiz = context.read<QuizProvider>();

    quiz.startQuiz(
      quiz.userName,
      category: category,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuizScreen(category: category),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  color: AppTheme.darkBrown,
                  size: 29,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppTheme.darkBrown,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: const TextStyle(
                        color: AppTheme.primaryColor,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      '10 soal',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 17,
                color: AppTheme.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}