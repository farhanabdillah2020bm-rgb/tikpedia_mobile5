import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000';

  // =========================
  // REGISTER
  // =========================

  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode >= 200 &&
        response.statusCode < 300) {
      return Map<String, dynamic>.from(data);
    }

    throw Exception(
      data['detail'] ?? 'Registrasi gagal',
    );
  }

  // =========================
  // LOGIN
  // =========================

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode >= 200 &&
        response.statusCode < 300) {
      return Map<String, dynamic>.from(data);
    }

    throw Exception(
      data['detail'] ?? 'Login gagal',
    );
  }

  // =========================
  // SELESAIKAN MATERI
  // =========================

  static Future<Map<String, dynamic>> completeMaterial({
    required int userId,
    required int materialId,
  }) async {
    final response = await http.post(
      Uri.parse(
        '$baseUrl/progress/material/$materialId',
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'user_id': userId,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode >= 200 &&
        response.statusCode < 300) {
      return Map<String, dynamic>.from(data);
    }

    throw Exception(
      data['detail'] ??
          'Gagal menyelesaikan materi',
    );
  }

  // =========================
  // SIMPAN HASIL QUIZ
  // =========================

  static Future<Map<String, dynamic>> saveQuizResult({
    required int userId,
    required int score,
    required int correctAnswers,
    required int totalQuestions,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/results/quiz'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'user_id': userId,
        'score': score,
        'correct_answers': correctAnswers,
        'total_questions': totalQuestions,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode >= 200 &&
        response.statusCode < 300) {
      return Map<String, dynamic>.from(data);
    }

    throw Exception(
      data['detail'] ??
          'Gagal menyimpan hasil quiz',
    );
  }

  // =========================
  // SIMPAN HASIL GAME
  // =========================

  static Future<Map<String, dynamic>> saveGameResult({
    required int userId,
    required String gameType,
    required int score,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/results/game'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'user_id': userId,
        'game_type': gameType,
        'score': score,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode >= 200 &&
        response.statusCode < 300) {
      return Map<String, dynamic>.from(data);
    }

    throw Exception(
      data['detail'] ??
          'Gagal menyimpan hasil game',
    );
  }

  // =========================
  // AMBIL PROGRESS USER
  // =========================

  static Future<Map<String, dynamic>> getProgress(
    int userId,
  ) async {
    final response = await http.get(
      Uri.parse('$baseUrl/progress/$userId'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode >= 200 &&
        response.statusCode < 300) {
      return Map<String, dynamic>.from(data);
    }

    throw Exception(
      data['detail'] ??
          'Gagal mengambil progress',
    );
  }
}