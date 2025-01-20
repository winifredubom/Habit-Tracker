
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habit_tracker/modules/models/habits.dart';

class HabitRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get user's habits
  Stream<List<Habit>> getUserHabits() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return Stream.value([]);

    return _firestore
        .collection('habits')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Habit.fromMap(doc.id, doc.data()))
            .toList());
  }

  // Add new habit
  Future<void> addHabit(String title) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw Exception('User not authenticated');

    final habit = Habit(
      id: '',
      userId: userId,
      title: title,
      currentStreak: 0,
      completionHistory: {},
      createdAt: DateTime.now(),
    );

    await _firestore.collection('habits').add(habit.toMap());
  }

  // Toggle habit completion for a specific date
  Future<void> toggleHabitCompletion(String habitId, DateTime date) async {
    final dateKey = '${date.year}-${date.month}-${date.day}';
    final habitDoc = await _firestore.collection('habits').doc(habitId).get();
    
    if (!habitDoc.exists) throw Exception('Habit not found');
    
    final habit = Habit.fromMap(habitDoc.id, habitDoc.data()!);
    final newCompletionHistory = Map<String, bool>.from(habit.completionHistory);
    newCompletionHistory[dateKey] = !(newCompletionHistory[dateKey] ?? false);

    // Calculate new streak
    int newStreak = calculateStreak(newCompletionHistory);

    await _firestore.collection('habits').doc(habitId).update({
      'completionHistory': newCompletionHistory,
      'currentStreak': newStreak,
    });
  }

  // Calculate streak based on completion history
  int calculateStreak(Map<String, bool> completionHistory) {
    if (completionHistory.isEmpty) return 0;

    final sortedDates = completionHistory.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList()
      ..sort();

    if (sortedDates.isEmpty) return 0;

    int currentStreak = 1;
    final today = DateTime.now();
    final yesterdayKey = '${today.year}-${today.month}-${today.day - 1}';

    if (!completionHistory.containsKey(yesterdayKey) || 
        !completionHistory[yesterdayKey]!) {
      return 0;
    }

    for (int i = sortedDates.length - 1; i > 0; i--) {
      final currentDate = _parseDate(sortedDates[i]);
      final previousDate = _parseDate(sortedDates[i - 1]);
      
      if (currentDate.difference(previousDate).inDays == 1) {
        currentStreak++;
      } else {
        break;
      }
    }

    return currentStreak;
  }

  DateTime _parseDate(String dateKey) {
    final parts = dateKey.split('-').map(int.parse).toList();
    return DateTime(parts[0], parts[1], parts[2]);
  }

  // Delete habit
  Future<void> deleteHabit(String habitId) async {
    await _firestore.collection('habits').doc(habitId).delete();
  }
}
