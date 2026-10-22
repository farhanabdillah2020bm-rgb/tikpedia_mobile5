import 'package:flutter/material.dart';

class AppTheme {
  static const primary = Color(0xFF1687F5);
  static const primaryDark = Color(0xFF1265C7);
  static const cyan = Color(0xFF17C7C0);

  static const background = Color(0xFFF3F8FF);
  static const text = Color(0xFF17324D);
  static const muted = Color(0xFF7D8EA3);
  static const border = Color(0xFFE3ECF5);

  static const success = Color(0xFF18B79B);
  static const orange = Color(0xFFFFB648);
  static const purple = Color(0xFF8A5CF6);

  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: primary,
    ).copyWith(
      primary: primary,
      secondary: cyan,
      surface: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,

      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: text,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: text,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: border,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: border,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: primary,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}