import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:uts_lab_pm/main.dart';
import 'package:uts_lab_pm/providers/quiz_provider.dart';

void main() {
  testWidgets('QuizPM menampilkan halaman welcome', (
      WidgetTester tester,
      ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => QuizProvider(),
        child: const QuizPMApp(),
      ),
    );

    expect(find.text('QuizPM'), findsOneWidget);
    expect(find.text('mulai kuis'), findsOneWidget);
    expect(find.text('siapa nama kamu?'), findsOneWidget);
  });

  testWidgets('nama kosong tidak bisa memulai kuis', (
      WidgetTester tester,
      ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => QuizProvider(),
        child: const QuizPMApp(),
      ),
    );

    await tester.tap(find.text('mulai kuis'));
    await tester.pump();

    expect(
      find.text('masukkan nama kamu terlebih dahulu, ya!'),
      findsOneWidget,
    );
  });
}