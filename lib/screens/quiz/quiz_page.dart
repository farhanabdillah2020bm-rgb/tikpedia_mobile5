import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../data/demo_data.dart';
import '../../services/app_state.dart';
import 'quiz_result_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestion = 0;
  int? selectedAnswer;

  final Map<int, int> answers = {};

  void selectAnswer(int index) {
    setState(() {
      selectedAnswer = index;
      answers[currentQuestion] = index;
    });
  }

  void nextQuestion() {
    if (selectedAnswer == null) {
      return;
    }

    if (currentQuestion < quizQuestions.length - 1) {
      setState(() {
        currentQuestion++;
        selectedAnswer = answers[currentQuestion];
      });
    } else {
      _finishQuiz();
    }
  }

  Future<void> _finishQuiz() async {
    int correctAnswers = 0;

    for (int i = 0; i < quizQuestions.length; i++) {
      final userAnswer = answers[i];
      final correctAnswer =
          quizQuestions[i].correctIndex;

      if (userAnswer == correctAnswer) {
        correctAnswers++;
      }
    }

    final score =
        ((correctAnswers / quizQuestions.length) * 100)
            .round();

    final success =
        await AppState.instance.saveQuizResult(
      score,
      correctAnswers,
      quizQuestions.length,
    );

    if (!mounted) {
      return;
    }

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Gagal menyimpan hasil kuis. Coba lagi.',
          ),
        ),
      );

      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => QuizResultPage(
          score: score,
          correctAnswers: correctAnswers,
          totalQuestions: quizQuestions.length,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question =
        quizQuestions[currentQuestion];

    final progress =
        (currentQuestion + 1) /
            quizQuestions.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kuis TIK'),
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
                    color: AppTheme.primary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${currentQuestion + 1}/${quizQuestions.length}',
                style: const TextStyle(
                  color: AppTheme.text,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(height: 26),

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
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Pertanyaan ${currentQuestion + 1}',
                  style: const TextStyle(
                    color: AppTheme.primary,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  question.question,
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

          const SizedBox(height: 22),

          ...List.generate(
            question.options.length,
            (index) {
              final selected =
                  selectedAnswer == index;

              return Padding(
                padding:
                    const EdgeInsets.only(
                  bottom: 12,
                ),
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(16),
                  onTap: () {
                    selectAnswer(index);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppTheme.primary
                              .withOpacity(.08)
                          : Colors.white,
                      borderRadius:
                          BorderRadius.circular(16),
                      border: Border.all(
                        color: selected
                            ? AppTheme.primary
                            : AppTheme.border,
                        width:
                            selected ? 1.5 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration:
                              BoxDecoration(
                            color: selected
                                ? AppTheme.primary
                                : AppTheme.primary
                                    .withOpacity(.08),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              String.fromCharCode(
                                65 + index,
                              ),
                              style: TextStyle(
                                color: selected
                                    ? Colors.white
                                    : AppTheme.primary,
                                fontWeight:
                                    FontWeight.w800,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Text(
                            question.options[index],
                            style: TextStyle(
                              color: AppTheme.text,
                              fontSize: 14,
                              fontWeight: selected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                        ),

                        if (selected)
                          const Icon(
                            Icons
                                .check_circle_rounded,
                            color:
                                AppTheme.primary,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 10),

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
                        quizQuestions.length - 1
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