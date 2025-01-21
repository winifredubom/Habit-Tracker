// components/enhanced_daily_summary_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DailySummaryCard extends ConsumerWidget {
  const DailySummaryCard({
    super.key,
    required this.completedTasks,
    required this.date,
    required this.totalTasks,
    this.onTap,
  });

  final int completedTasks;
  final DateTime date;
  final int totalTasks;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final completionRate = totalTasks > 0 ? (completedTasks / totalTasks) : 0.0;
    final formattedDate = DateFormat('EEEE, MMM d').format(date);

    return Card(
      elevation: 8,
      shadowColor: colorScheme.shadow.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              colors: [
                colorScheme.primary.withOpacity(0.8),
                colorScheme.secondary.withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Daily Progress',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(width: 8,),
                    Container(
                      padding:const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        formattedDate,
                        style: TextStyle(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: LinearProgressIndicator(
                        value: completionRate,
                        minHeight: 24,
                        backgroundColor: colorScheme.surface.withOpacity(0.2),
                        valueColor: AlwaysStoppedAnimation(
                          _getProgressColor(completionRate, colorScheme),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: Text(
                          '${(completionRate * 100).toInt()}%',
                          style: TextStyle(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: colorScheme.onPrimary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$completedTasks / $totalTasks Tasks',
                          style: TextStyle(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    _buildMotivationalMessage(completionRate, colorScheme),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getProgressColor(double rate, ColorScheme colorScheme) {
    if (rate >= 0.8) return Colors.green;
    if (rate >= 0.5) return colorScheme.primary;
    return colorScheme.error;
  }

  Widget _buildMotivationalMessage(double rate, ColorScheme colorScheme) {
    String message;
    IconData icon;

    if (rate >= 0.8) {
      message = 'Excellent!';
      icon = Icons.stars;
    } else if (rate >= 0.5) {
      message = 'Keep Going!';
      icon = Icons.trending_up;
    } else {
      message = 'You Got This!';
      icon = Icons.favorite;
    }

    return Row(
      children: [
        Icon(icon, color: colorScheme.onPrimary),
        const SizedBox(width: 4),
        Text(
          message,
          style: TextStyle(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
