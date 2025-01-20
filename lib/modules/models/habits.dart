
import 'package:cloud_firestore/cloud_firestore.dart';

class Habit {
  final String id;
  final String userId;
  final String title;
  final int currentStreak;
  final Map<String, bool> completionHistory;
  final DateTime createdAt;

  Habit({
    required this.id,
    required this.userId,
    required this.title,
    required this.currentStreak,
    required this.completionHistory,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'currentStreak': currentStreak,
      'completionHistory': completionHistory,
      'createdAt': createdAt,
    };
  }

  factory Habit.fromMap(String id, Map<String, dynamic> map) {
    return Habit(
      id: id,
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      currentStreak: map['currentStreak'] ?? 0,
      completionHistory: Map<String, bool>.from(map['completionHistory'] ?? {}),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}
