import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import 'quiz_page.dart';

class QuizResultPage extends StatelessWidget {
  final int score;
  final int correctAnswers;
  final int totalQuestions;

  const QuizResultPage({
    super.key,
    required this.score,
    required this.correctAnswers,
    required this.totalQuestions,
  });

  String get resultMessage {
    if (score >= 90) {
      return 'Luar biasa! Kamu sangat memahami materi TIK. 🏆';
    }

    if (score >= 70) {
      return 'Bagus! Pemahaman TIK kamu sudah cukup baik. 🎉';
    }

    if (score >= 50) {
      return 'Lumayan! Coba pelajari materi lagi dan ulangi kuis.';
    }

    return 'Jangan menyerah! Pelajari materi dan coba lagi. 💪';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Kuis'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 25),

            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(.10),
                shape: BoxShape.circle,
              ),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Text(
                    '$score',
                    style: const TextStyle(
                      color: AppTheme.primary,
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Text(
                    'NILAI',
                    style: TextStyle(
                      color: AppTheme.muted,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'Kuis Selesai! 🎉',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.text,
                fontSize: 25,
                fontWeight: FontWeight.w900,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              '$correctAnswers dari $totalQuestions jawaban benar',
              style: const TextStyle(
                color: AppTheme.muted,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppTheme.success.withOpacity(.10),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.stars_rounded,
                    color: AppTheme.orange,
                    size: 32,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '+250 XP berhasil ditambahkan!',
                      style: TextStyle(
                        color: AppTheme.text,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            Text(
              resultMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppTheme.text,
                fontSize: 15,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const QuizPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  backgroundColor:
                      AppTheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Ulangi Kuis',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  foregroundColor:
                      AppTheme.primary,
                  side: const BorderSide(
                    color: AppTheme.primary,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Kembali',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}