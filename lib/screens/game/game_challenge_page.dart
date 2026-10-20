import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../services/app_state.dart';

class GameChallengePage extends StatefulWidget {
  const GameChallengePage({super.key});

  @override
  State<GameChallengePage> createState() =>
      _GameChallengePageState();
}

class _GameChallengePageState
    extends State<GameChallengePage> {
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Apa kepanjangan dari TIK?',
      'options': [
        'Teknologi Informasi dan Komunikasi',
        'Teknik Informasi Komputer',
        'Teknologi Internet Komputer',
        'Teknik Informasi dan Komputer',
      ],
      'answer': 0,
    },
    {
      'question': 'Manakah yang termasuk perangkat keras?',
      'options': [
        'Microsoft Word',
        'Keyboard',
        'Google Chrome',
        'Windows',
      ],
      'answer': 1,
    },
    {
      'question':
          'Contoh perangkat untuk menampilkan gambar adalah...',
      'options': [
        'Keyboard',
        'Mouse',
        'Monitor',
        'Scanner',
      ],
      'answer': 2,
    },
    {
      'question': 'Internet digunakan untuk...',
      'options': [
        'Menghubungkan dan bertukar informasi',
        'Mematikan komputer',
        'Menghapus semua data',
        'Mengganti perangkat keras',
      ],
      'answer': 0,
    },
    {
      'question':
          'Contoh media penyimpanan data adalah...',
      'options': [
        'Monitor',
        'Speaker',
        'Flashdisk',
        'Keyboard',
      ],
      'answer': 2,
    },
  ];

  int currentQuestion = 0;
  int score = 0;
  int? selectedAnswer;

  void selectAnswer(int index) {
    if (selectedAnswer != null) {
      return;
    }

    setState(() {
      selectedAnswer = index;
    });
  }

  Future<void> nextQuestion() async {
    final correctAnswer =
        questions[currentQuestion]['answer'] as int;

    if (selectedAnswer == correctAnswer) {
      score += 20;
    }

    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
        selectedAnswer = null;
      });
    } else {
      final success =
          await AppState.instance.saveGameResult(
        'susun_kata',
        score,
      );

      if (!mounted) {
        return;
      }

      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Gagal menyimpan hasil game. Coba lagi.',
            ),
          ),
        );

        return;
      }

      _showResult();
    }
  }

  void _showResult() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Game Selesai! 🎉',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.emoji_events_rounded,
                color: AppTheme.orange,
                size: 70,
              ),
              const SizedBox(height: 12),
              Text(
                '$score / 100',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Kamu mendapatkan +200 XP!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Navigator.pop(context);
              },
              child: const Text('Kembali'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestion];

    final questionText =
        question['question'] as String;

    final options =
        question['options'] as List<String>;

    final correctAnswer =
        question['answer'] as int;

    final progress =
        (currentQuestion + 1) / questions.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Susun Kata'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 9,
                    backgroundColor:
                        const Color(0xFFE8F0F7),
                    color: AppTheme.cyan,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${currentQuestion + 1}/${questions.length}',
                style: const TextStyle(
                  color: AppTheme.text,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(20),
              border: Border.all(
                color: AppTheme.border,
              ),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.extension_rounded,
                  color: AppTheme.orange,
                  size: 44,
                ),
                const SizedBox(height: 14),
                Text(
                  questionText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppTheme.text,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          ...List.generate(
            options.length,
            (index) {
              final isSelected =
                  selectedAnswer == index;

              final isCorrect =
                  index == correctAnswer;

              Color backgroundColor =
                  Colors.white;

              Color borderColor =
                  AppTheme.border;

              Color textColor =
                  AppTheme.text;

              if (selectedAnswer != null) {
                if (isCorrect) {
                  backgroundColor =
                      AppTheme.success.withOpacity(.10);

                  borderColor =
                      AppTheme.success;

                  textColor =
                      AppTheme.success;
                } else if (isSelected) {
                  backgroundColor =
                      Colors.red.withOpacity(.08);

                  borderColor = Colors.red;

                  textColor = Colors.red;
                }
              }

              return Padding(
                padding:
                    const EdgeInsets.only(
                  bottom: 12,
                ),
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(16),
                  onTap: () =>
                      selectAnswer(index),
                  child: Container(
                    padding:
                        const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius:
                          BorderRadius.circular(16),
                      border: Border.all(
                        color: borderColor,
                        width: 1.4,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration:
                              BoxDecoration(
                            color: borderColor
                                .withOpacity(.10),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              String.fromCharCode(
                                65 + index,
                              ),
                              style: TextStyle(
                                color: textColor,
                                fontWeight:
                                    FontWeight.w800,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Text(
                            options[index],
                            style: TextStyle(
                              color: textColor,
                              fontSize: 14,
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),
                        ),

                        if (selectedAnswer != null &&
                            isCorrect)
                          const Icon(
                            Icons
                                .check_circle_rounded,
                            color:
                                AppTheme.success,
                          ),

                        if (selectedAnswer != null &&
                            isSelected &&
                            !isCorrect)
                          const Icon(
                            Icons.cancel_rounded,
                            color: Colors.red,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed:
                  selectedAnswer == null
                      ? null
                      : nextQuestion,
              style:
                  ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                backgroundColor:
                    AppTheme.primary,
                foregroundColor:
                    Colors.white,
                disabledBackgroundColor:
                    const Color(0xFFE0E8EF),
                disabledForegroundColor:
                    AppTheme.muted,
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(15),
                ),
              ),
              child: Text(
                currentQuestion ==
                        questions.length - 1
                    ? 'Selesai'
                    : 'Pertanyaan Berikutnya',
              ),
            ),
          ),
        ],
      ),
    );
  }
}