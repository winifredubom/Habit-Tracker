import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:habit_tracker/modules/screens/components/daily_summary_card.dart';
import 'package:habit_tracker/modules/screens/components/habit_card_lisr.dart';
import 'package:habit_tracker/modules/screens/components/timeline_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = useState(DateTime.now());
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
                selectedDate: selectedDate.value,
                selectedDateChange: (date) => selectedDate.value = date,
              ),
              const DailySummaryCard(
                  completedTasks: 10,
                  date: '2025-11-01',
                  totalTasks: 20),
               const  SizedBox(height: 16,),
               HabitCardList()
            ],
          ),
        ),
      ),
    );
  }
}
