import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../services/app_state.dart';
import '../../widgets/app_bottom_navigation.dart';
import '../../widgets/app_card.dart';

import '../game/game_page.dart';
import '../material/materials_page.dart';
import '../profile/profile_page.dart';
import '../progress/progress_page.dart';
import '../quiz/quiz_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildHomeContent(),
      const MaterialsPage(),
      const GamePage(),
      const ProgressPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: currentIndex,
        onTap: changePage,
      ),
    );
  }

  Widget _buildHomeContent() {
    final user = AppState.instance.user;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          20,
          18,
          20,
          28,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Halo 👋',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.muted,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.text,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppTheme.primary
                        .withOpacity(.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    color: AppTheme.primary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            // XP CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppTheme.primary,
                    AppTheme.primaryDark,
                  ],
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Level kamu',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${user.level}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          user.levelName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.bolt_rounded,
                        color: AppTheme.orange,
                        size: 32,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${user.xp} XP',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Mulai Belajar',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: AppTheme.text,
              ),
            ),

            const SizedBox(height: 12),

            // MENU UTAMA
            Row(
              children: [
                Expanded(
                  child: _menuCard(
                    icon: Icons.menu_book_rounded,
                    title: 'Materi',
                    subtitle: 'Belajar TIK',
                    color: AppTheme.primary,
                    onTap: () {
                      changePage(1);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _menuCard(
                    icon: Icons.quiz_rounded,
                    title: 'Kuis',
                    subtitle: 'Uji kemampuan',
                    color: AppTheme.cyan,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const QuizPage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _menuCard(
                    icon: Icons.sports_esports_rounded,
                    title: 'Game',
                    subtitle: 'Belajar sambil bermain',
                    color: AppTheme.purple,
                    onTap: () {
                      changePage(2);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _menuCard(
                    icon: Icons.insights_rounded,
                    title: 'Progress',
                    subtitle: 'Lihat perkembangan',
                    color: AppTheme.orange,
                    onTap: () {
                      changePage(3);
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // LANJUT BELAJAR
            const Text(
              'Lanjutkan Belajar',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: AppTheme.text,
              ),
            ),

            const SizedBox(height: 12),

            AppCard(
              onTap: () {
                changePage(1);
              },
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color:
                          AppTheme.primary.withOpacity(.10),
                      borderRadius:
                          BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.computer_rounded,
                      color: AppTheme.primary,
                      size: 28,
                    ),
                  ),

                  const SizedBox(width: 14),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Materi TIK',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Lanjutkan materi pembelajaranmu',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.muted,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: AppTheme.muted,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // INFO
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppTheme.cyan.withOpacity(.08),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: AppTheme.cyan.withOpacity(.15),
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.lightbulb_rounded,
                    color: AppTheme.cyan,
                    size: 28,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Selesaikan materi, kuis, dan game untuk mendapatkan XP dan badge!',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        color: AppTheme.text,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: color.withOpacity(.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: color,
              size: 25,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: AppTheme.text,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 10,
              color: AppTheme.muted,
            ),
          ),
        ],
      ),
    );
  }
}