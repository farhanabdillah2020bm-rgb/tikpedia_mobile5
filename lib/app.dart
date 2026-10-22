import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'screens/splash/splash_page.dart';

class TikpediaApp extends StatelessWidget {
  const TikpediaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TIKpedia Mobile',
      theme: AppTheme.light,
      home: const SplashPage(),
    );
  }
}