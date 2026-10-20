import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../services/app_state.dart';
import '../auth/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState.instance,
      builder: (context, child) {
        final u = AppState.instance.user;

        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              20,
              18,
              20,
              28,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Profil Saya',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.text,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Pengaturan akan tersedia pada tahap berikutnya.',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.settings_outlined,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Container(
                  width: 92,
                  height: 92,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFBDE6FF),
                        Color(0xFFE2F9F6),
                      ],
                    ),
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 52,
                    color: AppTheme.primary,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  u.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  u.email,
                  style: const TextStyle(
                    color: AppTheme.muted,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    _mini(
                      'LEVEL',
                      '${u.level}',
                    ),
                    _mini(
                      'TOTAL XP',
                      '${u.xp}',
                    ),
                    _mini(
                      'BADGE',
                      '${u.badges.length}',
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Pengaturan Akun',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                _setting(
                  Icons.person_outline,
                  'Informasi Profil',
                ),

                _setting(
                  Icons.notifications_none_rounded,
                  'Notifikasi',
                ),

                _setting(
                  Icons.lock_outline_rounded,
                  'Keamanan',
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      AppState.instance.logout();

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginPage(),
                        ),
                        (_) => false,
                      );
                    },
                    icon: const Icon(
                      Icons.logout_rounded,
                      color: Colors.redAccent,
                    ),
                    label: const Text(
                      'Keluar dari Akun',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _mini(
    String title,
    String value,
  ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 7),
        padding: const EdgeInsets.symmetric(
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 9,
                color: AppTheme.muted,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _setting(
    IconData icon,
    String title,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: AppTheme.primary,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
        ),
      ),
    );
  }
}