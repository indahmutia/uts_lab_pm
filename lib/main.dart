import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/quiz_provider.dart';
import 'screens/login_screen.dart';
import 'screens/category_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => QuizProvider(),
      child: const QuizPMApp(),
    ),
  );
}

class QuizPMApp extends StatelessWidget {
  const QuizPMApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuizPM',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const LoginScreen(),
    );
  }
}

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
  late final TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: widget.initialName ?? '',
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void startQuiz() {
    final String name = nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'masukkan nama kamu terlebih dahulu, ya!',
          ),
        ),
      );
      return;
    }

    context.read<QuizProvider>().startQuiz(name);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CategoryScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 440,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),

                  Center(
                    child: Container(
                      width: 112,
                      height: 112,
                      decoration: BoxDecoration(
                        color: AppTheme.lightBrown.withValues(
                          alpha: 0.45,
                        ),
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
                          'hai, calon juara! 👋',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.darkBrown,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          'siapa nama kamu?',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.primaryColor,
                          ),
                        ),

                        const SizedBox(height: 18),

                        TextField(
                          controller: nameController,
                          textCapitalization:
                          TextCapitalization.words,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => startQuiz(),
                          decoration: const InputDecoration(
                            hintText: 'masukkan nama lengkap',
                            prefixIcon: Icon(
                              Icons.person_outline_rounded,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        ElevatedButton.icon(
                          onPressed: startQuiz,
                          icon: const Icon(
                            Icons.play_arrow_rounded,
                          ),
                          label: const Text('mulai kuis'),
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
                          'pilihan kategori • pilihan ganda • lihat skor',
                          textAlign: TextAlign.center,
                          style: TextStyle(
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