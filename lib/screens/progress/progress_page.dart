import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../services/app_state.dart';
import '../../widgets/app_card.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState.instance,
      builder: (context, child) {
        final u = AppState.instance.user;
        final p = u.materialProgress;

        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              20,
              18,
              20,
              28,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Progress Belajar',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.text,
                  ),
                ),

                const SizedBox(height: 18),

                AppCard(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 105,
                        height: 105,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox.expand(
                              child: CircularProgressIndicator(
                                value: p,
                                strokeWidth: 10,
                                backgroundColor:
                                    const Color(0xFFEAF1F8),
                                color: AppTheme.primary,
                              ),
                            ),
                            Text(
                              '${(p * 100).round()}%',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 18),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Materi terselesaikan',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '${u.completedMaterials} dari 4 materi',
                              style: const TextStyle(
                                color: AppTheme.muted,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 13),
                            LinearProgressIndicator(
                              value: p,
                              minHeight: 7,
                              borderRadius:
                                  BorderRadius.circular(8),
                              color: AppTheme.primary,
                              backgroundColor:
                                  const Color(0xFFEAF1F8),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                GridView.count(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    _stat(
                      'NILAI KUIS',
                      '${u.quizScore}',
                      '/ 100',
                    ),
                    _stat(
                      'SKOR GAME',
                      '${u.gameScore}',
                      'total terbaik',
                    ),
                    _stat(
                      'TOTAL XP',
                      '${u.xp}',
                      'XP',
                    ),
                    _stat(
                      'LEVEL',
                      '${u.level}',
                      u.levelName,
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                const Text(
                  'Ringkasan Aktivitas',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                const SizedBox(height: 10),

                AppCard(
                  child: Column(
                    children: [
                      _line(
                        'Materi TIK',
                        p,
                        AppTheme.primary,
                      ),

                      const SizedBox(height: 18),

                      _line(
                        'Kuis',
                        u.quizScore / 100,
                        AppTheme.cyan,
                      ),

                      const SizedBox(height: 18),

                      _line(
                        'Game',
                        u.gameScore / 3000,
                        AppTheme.purple,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                const Text(
                  'Badge',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                const SizedBox(height: 10),

                u.badges.isEmpty
                    ? const AppCard(
                        child: Text(
                          'Belum ada badge. Kumpulkan XP untuk membuka pencapaian!',
                          style: TextStyle(
                            color: AppTheme.muted,
                          ),
                        ),
                      )
                    : Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: u.badges
                            .map(
                              (b) => Chip(
                                avatar: const Icon(
                                  Icons
                                      .workspace_premium_rounded,
                                  color: AppTheme.orange,
                                ),
                                label: Text(b),
                              ),
                            )
                            .toList(),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _stat(
    String title,
    String value,
    String subtitle,
  ) {
    return AppCard(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 9,
              color: AppTheme.muted,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 9,
              color: AppTheme.muted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _line(
    String name,
    double value,
    Color color,
  ) {
    final progress = value.clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '${(progress * 100).round()}%',
              style: const TextStyle(
                fontSize: 11,
                color: AppTheme.muted,
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        LinearProgressIndicator(
          value: progress,
          minHeight: 7,
          borderRadius:
              BorderRadius.circular(8),
          color: color,
          backgroundColor:
              const Color(0xFFEAF1F8),
        ),
      ],
    );
  }
}