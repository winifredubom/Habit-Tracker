import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/modules/provider/providers.dart';
import 'package:habit_tracker/modules/screens/components/daily_summary_card.dart';
import 'package:habit_tracker/modules/screens/components/habit_card.dart';
import 'package:habit_tracker/modules/screens/components/sign_out_dialog.dart';
import 'package:habit_tracker/modules/screens/components/timeline_view.dart';
import 'package:habit_tracker/modules/screens/home/new_habit_dialog.dart';

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final stats = ref.watch(dailyStatsProvider(selectedDate));
    final habitRepository = ref.watch(habitRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Habit Tracker'), ),
        actions: [
          IconButton( onPressed: () {
    showDialog(
      context: context,
      builder: (context) => const SignOutDialog(),
    );
  },
           icon:const Icon(Icons.person_2_rounded, size: 30,))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TimelineView(
                selectedDate: selectedDate,
                selectedDateChange: (date) => ref.read(selectedDateProvider.notifier).state = date,
              ),
              DailySummaryCard(
       completedTasks: stats.completedTasks,
                totalTasks: stats.totalTasks,
                date: selectedDate,
                onTap: () {
                },
              ),
              const SizedBox(height: 16),
             Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    final habitsAsync = ref.watch(userHabitsProvider);
                    
                    return habitsAsync.when(
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (err, _) => Center(child: Text('Error: $err')),
                      data: (habits) => ListView.separated(
                        itemCount: habits.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final habit = habits[index];
                          return HabitCard(
                            title: habit.title,
                            streak: habit.currentStreak,
                            habitId: habit.id,
                            date: selectedDate,
                            isCompleted: habit.completionHistory[
                              '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}'
                            ] ?? false,
                            onToggle: () => habitRepository.toggleHabitCompletion(
                              habit.id,
                              selectedDate,
                            ),
                            onEdit: () {
                            },
                            onDelete: () => habitRepository.deleteHabit(habit.id),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
         onPressed: () {
    showDialog(
      context: context,
      builder: (context) => NewHabitDialog(),
    );
  },
        child: const Icon(Icons.add),
      ),
    );
  }
}
