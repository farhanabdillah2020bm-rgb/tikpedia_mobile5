import 'package:flutter/foundation.dart';

import '../models/user_model.dart';
import 'api_service.dart';

class AppState extends ChangeNotifier {
  AppState._();

  static final AppState instance = AppState._();

  UserModel user = UserModel();

  final Set<int> completedMaterialIds = {};
  final Map<String, int> bestGameScores = {};

  bool loggedIn = false;
  bool loadingBackend = false;

  Future<bool> login(
    String email,
    String password,
  ) async {
    if (email.trim().isEmpty) {
      return false;
    }

    if (password.length < 4) {
      return false;
    }

    try {
      final response = await ApiService.login(
        email: email.trim(),
        password: password,
      );

      final data = Map<String, dynamic>.from(
        response['user'] as Map,
      );

      user = UserModel(
        id: (data['id'] as num?)?.toInt() ?? 1,
        name: data['name']?.toString() ?? 'Pelajar TIK',
        email: data['email']?.toString() ?? email.trim(),
        xp: (data['xp'] as num?)?.toInt() ?? 0,
        quizScore: (data['quiz_score'] as num?)?.toInt() ?? 0,
        gameScore: (data['game_score'] as num?)?.toInt() ?? 0,
      );

      user.syncBadgesFromXp();
      loggedIn = true;

      notifyListeners();

      await refreshFromBackend();

      return true;
    } catch (e) {
      debugPrint('Login error: $e');
      return false;
    }
  }

  Future<bool> register(
    String name,
    String email,
    String password,
  ) async {
    if (name.trim().isEmpty) {
      return false;
    }

    if (!email.contains('@')) {
      return false;
    }

    if (password.length < 4) {
      return false;
    }

    try {
      final response = await ApiService.register(
        name: name.trim(),
        email: email.trim(),
        password: password,
      );

      final data = Map<String, dynamic>.from(
        response['user'] as Map,
      );

      user = UserModel(
        id: (data['id'] as num?)?.toInt() ?? 1,
        name: data['name']?.toString() ?? name.trim(),
        email: data['email']?.toString() ?? email.trim(),
        xp: (data['xp'] as num?)?.toInt() ?? 0,
      );

      user.syncBadgesFromXp();

      completedMaterialIds.clear();
      bestGameScores.clear();

      loggedIn = true;

      notifyListeners();

      await refreshFromBackend();

      return true;
    } catch (e) {
      debugPrint('Register error: $e');
      return false;
    }
  }

  Future<void> refreshFromBackend() async {
    if (!loggedIn || user.id <= 0) {
      return;
    }

    try {
      loadingBackend = true;
      notifyListeners();

      final data = await ApiService.getProgress(user.id);

      user.name =
          data['name']?.toString() ?? user.name;

      user.email =
          data['email']?.toString() ?? user.email;

      user.xp =
          (data['xp'] as num?)?.toInt() ?? user.xp;

      user.quizScore =
          (data['quiz_score'] as num?)?.toInt() ??
          user.quizScore;

      user.gameScore =
          (data['game_score'] as num?)?.toInt() ??
          user.gameScore;

      user.completedMaterials =
          (data['completed_materials'] as num?)?.toInt() ??
          user.completedMaterials;

      user.syncBadgesFromXp();

      notifyListeners();
    } catch (e) {
      debugPrint('Refresh backend error: $e');
    } finally {
      loadingBackend = false;
      notifyListeners();
    }
  }

  Future<bool> completeMaterial(
    int materialId,
  ) async {
    try {
      final response =
          await ApiService.completeMaterial(
        userId: user.id,
        materialId: materialId,
      );

      completedMaterialIds.add(materialId);

      await refreshFromBackend();

      return response['message'] != null;
    } catch (e) {
      debugPrint('Complete material error: $e');
      return false;
    }
  }

  Future<bool> saveQuizResult(
    int score,
    int correctAnswers,
    int totalQuestions,
  ) async {
    try {
      await ApiService.saveQuizResult(
        userId: user.id,
        score: score,
        correctAnswers: correctAnswers,
        totalQuestions: totalQuestions,
      );

      await refreshFromBackend();

      return true;
    } catch (e) {
      debugPrint('Save quiz result error: $e');
      return false;
    }
  }

  Future<bool> saveGameResult(
    String gameType,
    int score,
  ) async {
    try {
      await ApiService.saveGameResult(
        userId: user.id,
        gameType: gameType,
        score: score,
      );

      final oldScore =
          bestGameScores[gameType] ?? 0;

      if (score > oldScore) {
        bestGameScores[gameType] = score;
      }

      await refreshFromBackend();

      return true;
    } catch (e) {
      debugPrint('Save game result error: $e');
      return false;
    }
  }

  void logout() {
    loggedIn = false;

    completedMaterialIds.clear();
    bestGameScores.clear();

    notifyListeners();
  }
}