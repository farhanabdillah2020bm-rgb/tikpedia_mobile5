class UserModel {
  int id;
  String name;
  String email;

  int xp;
  int quizScore;
  int gameScore;

  int completedMaterials;
  int quizAttempts;
  int gameAttempts;

  List<String> badges;

  UserModel({
    this.id = 1,
    this.name = 'Pelajar TIK',
    this.email = 'pelajar@tikpedia.com',
    this.xp = 0,
    this.quizScore = 0,
    this.gameScore = 0,
    this.completedMaterials = 0,
    this.quizAttempts = 0,
    this.gameAttempts = 0,
    List<String>? badges,
  }) : badges = badges ?? [];

  // =========================
  // LEVEL BERDASARKAN XP
  // =========================

  int get level {
    if (xp >= 1500) return 5;
    if (xp >= 1000) return 4;
    if (xp >= 750) return 3;
    if (xp >= 500) return 2;

    return 1;
  }

  // =========================
  // NAMA LEVEL
  // =========================

  String get levelName {
    switch (level) {
      case 5:
        return 'TIK Master';

      case 4:
        return 'Tech Starter';

      case 3:
        return 'Tech Explorer';

      case 2:
        return 'Digital Explorer';

      default:
        return 'TIK Beginner';
    }
  }

  // =========================
  // PROGRESS MATERI
  // =========================

  double get materialProgress {
    return (completedMaterials / 4).clamp(
      0.0,
      1.0,
    );
  }

  // =========================
  // SINKRON BADGE DENGAN XP
  // =========================

  void syncBadgesFromXp() {
    badges.clear();

    if (xp >= 500) {
      badges.add('Digital Explorer');
    }

    if (xp >= 1000) {
      badges.add('TIK Master');
    }
  }

  // =========================
  // TAMBAH XP
  // =========================

  void addXp(int amount) {
    xp += amount;
    syncBadgesFromXp();
  }
}