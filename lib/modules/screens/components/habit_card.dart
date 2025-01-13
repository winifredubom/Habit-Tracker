import 'package:flutter/material.dart';

class HabitCard extends StatelessWidget {
  const HabitCard(
      {super.key,
      required this.title,
      required this.streak,
      required this.progress,
      required this.habitId,
      required this.date,
      required this.isCompleted});

  final String title;
  final String streak;
  final double progress;
  final String habitId;
  final bool isCompleted;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
