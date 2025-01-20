import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/modules/provider/providers.dart';
import 'package:habit_tracker/modules/screens/components/habit_card.dart';

class HabitCardList extends ConsumerWidget {
  const HabitCardList({super.key, required this.selectedDate});

  final DateTime selectedDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(userHabitsProvider);
    
    return habitsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (habits) => Expanded(
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemCount: habits.length,
          itemBuilder: (context, index) {
            final habit = habits[index];
            final dateKey = '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
            
            return HabitCard(
              title: habit.title,
              streak: habit.currentStreak,
              habitId: habit.id,
              isCompleted: habit.completionHistory[dateKey] ?? false,
              date: selectedDate,
            );
          },
        ),
      ),
    );
  }
}