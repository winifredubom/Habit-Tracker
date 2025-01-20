import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:habit_tracker/modules/models/daily_stats.dart';
import 'package:habit_tracker/modules/models/habit_repository.dart';
import 'package:habit_tracker/modules/models/habits.dart';

// FirebaseAuth instance provider
final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

// GoogleSignIn instance provider
final googleSignInProvider = Provider((ref) => GoogleSignIn());

// User state provider
final authStateProvider = StreamProvider<User?>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return auth.authStateChanges();
});

final habitRepositoryProvider = Provider((ref) => HabitRepository());

final userHabitsProvider = StreamProvider<List<Habit>>((ref) {
  final repository = ref.watch(habitRepositoryProvider);
  return repository.getUserHabits();
});

final dailyStatsProvider = Provider.family<DailyStats, DateTime>((ref, date) {
  final habits = ref.watch(userHabitsProvider).value ?? [];
  final dateKey = '${date.year}-${date.month}-${date.day}';

 final completedTasks = habits.where((habit) => 
    habit.completionHistory[dateKey] ?? false).length;
  
  return DailyStats(
    completedTasks: completedTasks,
    totalTasks: habits.length,
    date: dateKey,
  );
});