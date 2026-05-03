class QuizResultModel {
  final int id;
  final int quizId;
  final String quizName;
  final double? score;
  final double totalScore;
  final String? takenAt;
  final String? teacherName;
  final String? lectureName;
  final String? unitName;
  final String? subjectName;
  final String? submissionTime;

  QuizResultModel({
    required this.id,
    required this.quizId,
    required this.quizName,
    this.score,
    required this.totalScore,
    this.takenAt,
    this.teacherName,
    this.lectureName,
    this.unitName,
    this.subjectName,
    this.submissionTime,
  });

  factory QuizResultModel.fromJson(Map<String, dynamic> json) {
    return QuizResultModel(
      id: json['id'] ?? 0,
      quizId: json['quizId'] ?? 0,
      quizName: json['quizName'] ?? '',
      score: json['score'] != null ? (json['score'] as num).toDouble() : null,
      totalScore: json['totalScore'] != null
          ? (json['totalScore'] as num).toDouble()
          : 100,
      takenAt: json['takenAt'],
      teacherName: json['teacherName'],
      lectureName: json['lectureName'],
      unitName: json['unitName'],
      subjectName: json['subjectName'],
      submissionTime: json['submissionTime'],
    );
  }

  // الحالة بناءً على النسبة المئوية
  QuizStatus get status {
    if (score == null || score == -1) return QuizStatus.notTaken;
    final pct = (score! / totalScore) * 100;
    if (pct >= 75) return QuizStatus.passed;
    if (pct >= 50) return QuizStatus.needsImprovement;
    return QuizStatus.failed;
  }

  String get displayDate {
    final raw = submissionTime ?? takenAt;
    if (raw == null) return '';
    try {
      final d = DateTime.parse(raw);
      return '${d.day.toString().padLeft(2, '0')}-'
          '${d.month.toString().padLeft(2, '0')}-'
          '${d.year}';
    } catch (_) {
      return raw;
    }
  }

  String get displayScore {
    if (score == null || score == -1) return 'لم يمتحن بعد';
    return '${score!.toStringAsFixed(2)} / ${totalScore.toStringAsFixed(0)}';
  }
}

enum QuizStatus { notTaken, passed, needsImprovement, failed }