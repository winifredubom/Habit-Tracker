import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/modules/screens/components/daily_summary_card.dart';
import 'package:habit_tracker/modules/screens/components/habit_card_lisr.dart';
import 'package:habit_tracker/modules/screens/components/timeline_view.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/modules/screens/components/daily_summary_card.dart';
import 'package:habit_tracker/modules/screens/components/habit_card_lisr.dart';
import 'package:habit_tracker/modules/screens/components/timeline_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Habit Tracker')),
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
              const DailySummaryCard(
                  completedTasks: 10,
                  date: '2025-11-01',
                  totalTasks: 20),
              const SizedBox(height: 16),
              HabitCardList(selectedDate: selectedDate),
            ],
          ),
        ),
      ),
    );
  }
}