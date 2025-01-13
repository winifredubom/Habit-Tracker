import 'package:flutter/material.dart';
import 'package:habit_tracker/modules/screens/components/habit_card.dart';

class HabitCardList extends StatelessWidget {
  const HabitCardList({super.key, required this.selectedDate});

  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => 
         HabitCard(
          title: 'Habit $index',
          streak: 2,
          progress: 0.5,
          habitId: 'Habit $index',
          isCompleted: index % 2 == 0,
          date: selectedDate,

         ),
      ),
    );
  }
}