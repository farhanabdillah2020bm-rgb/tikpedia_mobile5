import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../services/app_state.dart';

class MemoryMatchPage extends StatefulWidget {
  const MemoryMatchPage({super.key});

  @override
  State<MemoryMatchPage> createState() => _MemoryMatchPageState();
}

class _MemoryMatchPageState extends State<MemoryMatchPage> {
  final List<String> _symbols = [
    '💻',
    '💻',
    '🖱️',
    '🖱️',
    '⌨️',
    '⌨️',
    '🌐',
    '🌐',
    '📱',
    '📱',
    '🖨️',
    '🖨️',
  ];

  late List<String> cards;
  late List<bool> revealed;
  late List<bool> matched;

  int? firstIndex;
  int? secondIndex;

  bool checking = false;
  int moves = 0;
  int pairsFound = 0;

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    cards = List<String>.from(_symbols)..shuffle(Random());

    revealed = List<bool>.filled(
      cards.length,
      false,
    );

    matched = List<bool>.filled(
      cards.length,
      false,
    );

    firstIndex = null;
    secondIndex = null;
    checking = false;
    moves = 0;
    pairsFound = 0;
  }

  void _tapCard(int index) {
    if (checking ||
        revealed[index] ||
        matched[index]) {
      return;
    }

    setState(() {
      revealed[index] = true;
    });

    if (firstIndex == null) {
      firstIndex = index;
      return;
    }

    secondIndex = index;
    moves++;

    _checkPair();
  }

  Future<void> _checkPair() async {
    checking = true;

    final first = firstIndex!;
    final second = secondIndex!;

    if (cards[first] == cards[second]) {
      await Future<void>.delayed(
        const Duration(milliseconds: 450),
      );

      if (!mounted) {
        return;
      }

      setState(() {
        matched[first] = true;
        matched[second] = true;
        pairsFound++;

        firstIndex = null;
        secondIndex = null;
        checking = false;
      });

      if (pairsFound == cards.length ~/ 2) {
        _finishGame();
      }
    } else {
      await Future<void>.delayed(
        const Duration(milliseconds: 800),
      );

      if (!mounted) {
        return;
      }

      setState(() {
        revealed[first] = false;
        revealed[second] = false;

        firstIndex = null;
        secondIndex = null;
        checking = false;
      });
    }
  }

  Future<void> _finishGame() async {
    final score = max(
      0,
      100 - ((moves - 6) * 5),
    );

    final success = await AppState.instance.saveGameResult(
      'memory_match',
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

    await Future<void>.delayed(
      const Duration(milliseconds: 300),
    );

    if (!mounted) {
      return;
    }

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Memory Match Selesai! 🎉',
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
              Text(
                'Selesai dalam $moves percobaan.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Kamu mendapatkan +200 XP!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
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
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                setState(() {
                  _startGame();
                });
              },
              child: const Text('Main Lagi'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Match'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              12,
              20,
              10,
            ),
            child: Row(
              children: [
                Expanded(
                  child: _InfoCard(
                    icon: Icons.touch_app_rounded,
                    title: 'Percobaan',
                    value: '$moves',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _InfoCard(
                    icon: Icons.favorite_rounded,
                    title: 'Pasangan',
                    value: '$pairsFound/6',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            child: Text(
              'Temukan semua pasangan kartu yang sama!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.muted,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: cards.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final visible =
                    revealed[index] || matched[index];

                return GestureDetector(
                  onTap: () => _tapCard(index),
                  child: AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 180,
                    ),
                    decoration: BoxDecoration(
                      color: visible
                          ? Colors.white
                          : AppTheme.primary,
                      borderRadius:
                          BorderRadius.circular(18),
                      border: Border.all(
                        color: matched[index]
                            ? AppTheme.success
                            : visible
                                ? AppTheme.border
                                : AppTheme.primary,
                        width: matched[index] ? 2 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Colors.black.withOpacity(.04),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: visible
                          ? Text(
                              cards[index],
                              style: const TextStyle(
                                fontSize: 36,
                              ),
                            )
                          : const Icon(
                              Icons.question_mark_rounded,
                              color: Colors.white,
                              size: 32,
                            ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.border,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppTheme.primary,
            size: 24,
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppTheme.muted,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: AppTheme.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}