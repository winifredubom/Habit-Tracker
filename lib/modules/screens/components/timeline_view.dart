import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';

class TimelineView extends StatelessWidget {
  const TimelineView(
      {super.key,
      required this.selectedDate,
      required this.selectedDateChange});

  final DateTime selectedDate;
  final void Function(DateTime) selectedDateChange;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: EasyDateTimeLine(
        initialDate: selectedDate,
        onDateChange: selectedDateChange,
      ),
    );
  }
}
