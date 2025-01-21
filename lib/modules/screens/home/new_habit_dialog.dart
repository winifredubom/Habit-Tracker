import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/modules/provider/providers.dart';

class NewHabitDialog extends ConsumerWidget {
   NewHabitDialog({super.key});

  
  final titleController = TextEditingController();
  final streakController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
          title: const Text('Add New Habit'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Habit Title'),
              ),
              TextField(
                controller: streakController,
                decoration: const InputDecoration(labelText: 'Streak'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final title = titleController.text;
               // final streak = int.tryParse(streakController.text) ?? 0;

                if (title.isNotEmpty) {
                    ref.read(habitRepositoryProvider).addHabit(title);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
  }
}