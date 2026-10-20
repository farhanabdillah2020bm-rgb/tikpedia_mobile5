import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../models/material_model.dart';
import '../../services/app_state.dart';

class MaterialDetailPage extends StatelessWidget {
  final MaterialModel material;

  const MaterialDetailPage({
    super.key,
    required this.material,
  });

  @override
  Widget build(BuildContext context) {
    final appState = AppState.instance;

    final isCompleted =
        appState.completedMaterialIds.contains(material.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(material.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppTheme.primary,
                    AppTheme.cyan,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                children: [
                  Text(
                    material.icon,
                    style: const TextStyle(
                      fontSize: 55,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    material.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Materi ${material.order}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Tentang Materi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppTheme.text,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              material.description,
              style: const TextStyle(
                fontSize: 15,
                color: AppTheme.muted,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Isi Materi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppTheme.text,
              ),
            ),

            const SizedBox(height: 10),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: AppTheme.border,
                ),
              ),
              child: Text(
                material.content,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppTheme.text,
                  height: 1.7,
                ),
              ),
            ),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.orange.withOpacity(.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.stars_rounded,
                    color: AppTheme.orange,
                    size: 30,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Selesaikan materi untuk mendapatkan +50 XP.',
                      style: TextStyle(
                        color: AppTheme.text,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: isCompleted
                    ? null
                    : () async {
                        final success =
                            await appState.completeMaterial(
                          material.id,
                        );

                        if (!context.mounted) {
                          return;
                        }

                        if (success) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Materi selesai! Kamu mendapatkan +50 XP 🎉',
                              ),
                            ),
                          );

                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Gagal menyimpan progress materi.',
                              ),
                            ),
                          );
                        }
                      },
                icon: Icon(
                  isCompleted
                      ? Icons.check_circle_rounded
                      : Icons.check_rounded,
                ),
                label: Text(
                  isCompleted
                      ? 'Materi Sudah Selesai'
                      : 'Tandai Materi Selesai',
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  backgroundColor: AppTheme.primary,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor:
                      AppTheme.success.withOpacity(.15),
                  disabledForegroundColor:
                      AppTheme.success,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
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