
// components/enhanced_habit_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HabitCard extends ConsumerWidget {
  const HabitCard({
    super.key,
    required this.title,
    required this.streak,
    required this.habitId,
    required this.date,
    required this.isCompleted,
    this.onToggle,
    this.onEdit,
    this.onDelete,
  });

  final String title;
  final int streak;
  final String habitId;
  final DateTime date;
  final bool isCompleted;
  final Function()? onToggle;
  final Function()? onEdit;
  final Function()? onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return Dismissible(
      key: Key(habitId),
      background: _buildDismissBackground(context, DismissDirection.endToStart),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Habit'),
            content: const Text('Are you sure you want to delete this habit?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  onDelete?.call();
                },
                child: const Text('Delete'),
              ),
            ],
          ),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                isCompleted
                    ? colorScheme.primaryContainer
                    : colorScheme.surface,
                isCompleted
                    ? colorScheme.primaryContainer.withOpacity(0.8)
                    : colorScheme.surface,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Completion checkbox
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isCompleted
                              ? colorScheme.primary
                              : colorScheme.surface,
                          border: Border.all(
                            color: colorScheme.primary,
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: isCompleted
                              ? Icon(
                                  Icons.check,
                                  size: 20,
                                  color: colorScheme.onPrimary,
                                )
                              : const SizedBox(
                                  width: 20,
                                  height: 20,
                                ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Habit title and streak
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: isCompleted
                                    ? colorScheme.onPrimaryContainer
                                    : colorScheme.onSurface,
                              ),
                            ),
                            if (streak > 0) ...[
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.local_fire_department,
                                    color: colorScheme.error,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '$streak day streak!',
                                    style: TextStyle(
                                      color: isCompleted
                                          ? colorScheme.onPrimaryContainer
                                          : colorScheme.onSurface,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                      // Edit button
                      IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        onPressed: onEdit,
                        tooltip: 'Edit Habit',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDismissBackground(BuildContext context, DismissDirection direction) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.error,
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: direction == DismissDirection.endToStart
          ? Alignment.centerRight
          : Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.delete_forever,
            color: colorScheme.onError,
          ),
          const SizedBox(width: 8),
          Text(
            'Delete',
            style: TextStyle(
              color: colorScheme.onError,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}