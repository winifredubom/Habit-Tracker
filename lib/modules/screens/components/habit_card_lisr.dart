import 'package:flutter/material.dart';
import 'package:habit_tracker/modules/screens/components/habit_card.dart';

class HabitCardList extends StatelessWidget {
  const HabitCardList({super.key, required this.selectedDate});

  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: 10,
        itemBuilder: (context, index) => 
         HabitCard(
          title: 'Habit $index',
          streak: 10,
          progress: 0.5,
          habitId: 'Habit $index',
          isCompleted: index % 2 == 0,
          date: selectedDate,

         ),
      ),
    );
  }
}