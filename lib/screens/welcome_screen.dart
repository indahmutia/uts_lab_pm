import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  final String? initialName;

  const WelcomeScreen({
    super.key,
    this.initialName,
  });

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.initialName ?? '';
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void startQuiz() {
    final name = nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan nama kamu terlebih dahulu, ya!'),
        ),
      );
      return;
    }

    context.read<QuizProvider>().startQuiz(name);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),
                  Center(
                    child: Container(
                      width: 112,
                      height: 112,
                      decoration: BoxDecoration(
                        color: AppTheme.lightBrown.withValues(alpha: 0.45),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: const Icon(
                        Icons.quiz_rounded,
                        size: 64,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'QuizPM',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.darkBrown,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'quiz pemrograman mobile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'asah pengetahuanmu tentang Flutter dan Dart '
                        'melalui kuis yang seru dan interaktif!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      height: 1.6,
                      color: AppTheme.darkBrown,
                    ),
                  ),
                  const SizedBox(height: 36),
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: AppTheme.cardColor,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: AppTheme.lightBrown,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Hai, calon juara! 👋',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 21,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.darkBrown,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Masukkan nama kamu untuk mulai kuis.',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 18),
                        TextField(
                          controller: nameController,
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => startQuiz(),
                          decoration: const InputDecoration(
                            hintText: 'Nama lengkap kamu',
                            prefixIcon: Icon(
                              Icons.person_outline_rounded,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        PrimaryButton(
                          text: 'Mulai Kuis',
                          icon: Icons.play_arrow_rounded,
                          onPressed: startQuiz,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.menu_book_rounded,
                        size: 17,
                        color: AppTheme.primaryColor,
                      ),
                      SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          '10 soal • pilihan ganda • lihat skor',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                    ],
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