import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class AppProgressBar extends StatelessWidget {
  final double value;

  const AppProgressBar({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: LinearProgressIndicator(
        value: value.clamp(0.0, 1.0).toDouble(),
        minHeight: 8,
        backgroundColor: const Color(0xFFE8F0F7),
        color: AppTheme.cyan,
      ),
    );
  }
}