import 'package:flutter/material.dart';

class DailySummaryCard extends StatelessWidget {
  const DailySummaryCard(
      {super.key,
      required this.completedTasks,
      required this.date,
      required this.totalTasks});

  final int completedTasks;
  final int totalTasks;
  final String date;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 8,
      shadowColor: colorScheme.shadow.withOpacity(0.2),
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
                colors: [colorScheme.primary, colorScheme.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Daily Summary',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                        color: colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      date,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: LinearProgressIndicator(
                      value: completedTasks / totalTasks,
                      minHeight: 20,
                      backgroundColor: colorScheme.surface.withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation(colorScheme.primary),
                    ),
                  ),
                 
                ],
              ),
             const SizedBox(height: 24,),
              Row(
                children: [
                 const Icon(Icons.check_circle,),
                 const SizedBox(width: 8,),
                  Text(
                    '$completedTasks / $totalTasks',
                    style: TextStyle(
                      color: colorScheme.onPrimaryContainer,

                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
