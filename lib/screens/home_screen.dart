import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../theme/app_theme.dart';
import 'category_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();

    final String userName =
    quiz.userName.trim().isEmpty ? 'Teman' : quiz.userName.trim();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'QuizPM',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Pilih kategori',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CategoryScreen(),
                ),
              );
            },
            icon: const Icon(Icons.category_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 520,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Sapaan pengguna.
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.waving_hand_rounded,
                          color: Colors.white,
                          size: 36,
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'Halo, $userName!',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Siap menguji pengetahuanmu hari ini? '
                              'Pilih kategori dan mulai tantanganmu!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 22),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                  const CategoryScreen(),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.play_arrow_rounded,
                            ),
                            label: const Text('Mulai Kuis'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.cardColor,
                              foregroundColor: AppTheme.darkBrown,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  const Text(
                    'Jelajahi Kategori',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkBrown,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Pilih materi yang ingin kamu pelajari.',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppTheme.primaryColor,
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Daftar kategori.
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    shrinkWrap: true,
                    physics:
                    const NeverScrollableScrollPhysics(),
                    childAspectRatio: 1.05,
                    children: const [
                      _CategoryPreviewCard(
                        title: 'Flutter',
                        description: 'Framework aplikasi',
                        icon: Icons.phone_android_rounded,
                      ),
                      _CategoryPreviewCard(
                        title: 'Dart',
                        description: 'Bahasa pemrograman',
                        icon: Icons.code_rounded,
                      ),
                      _CategoryPreviewCard(
                        title: 'UI/UX',
                        description: 'Desain antarmuka',
                        icon: Icons.design_services_rounded,
                      ),
                      _CategoryPreviewCard(
                        title: 'Pemrograman Mobile',
                        description: 'Dasar aplikasi mobile',
                        icon: Icons.smartphone_rounded,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Informasi kuis.
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppTheme.cardColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppTheme.lightBrown,
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.lightbulb_outline_rounded,
                          size: 32,
                          color: AppTheme.primaryColor,
                        ),
                        SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tips untuk kamu',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.darkBrown,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Baca setiap soal dengan teliti '
                                    'sebelum memilih jawaban.',
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 1.5,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryPreviewCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const _CategoryPreviewCard({
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.cardColor,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CategoryScreen(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: AppTheme.lightBrown,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppTheme.lightBrown.withValues(
                    alpha: 0.4,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  icon,
                  color: AppTheme.primaryColor,
                  size: 27,
                ),
              ),
              const SizedBox(height: 13),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkBrown,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppTheme.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}