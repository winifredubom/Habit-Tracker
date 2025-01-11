// ignore_for_file: deprecated_member_use

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
        headerProps:const EasyHeaderProps(
          monthPickerType: MonthPickerType.dropDown,
          showHeader: true,
          showSelectedDate: true,
          monthStyle: TextStyle(
            fontWeight: FontWeight.w900 ,

          )
        ) ,
        dayProps: EasyDayProps(
          dayStructure: DayStructure.dayNumDayStr,
          activeDayStyle: DayStyle(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(colors: [colorScheme.primary, colorScheme.secondary],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)
            ),
            dayStrStyle:const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),
            dayNumStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black
            )
          ),
          inactiveDayStyle: DayStyle(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: colorScheme.surface,
              border: Border.all(
                color: colorScheme.outlineVariant,
                width: 1
              )
            ),
            dayStrStyle:const TextStyle(
              color: Colors.white,
              fontSize: 16
            )
          ),
          inactiveDayNumStyle:const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          todayHighlightStyle: TodayHighlightStyle.withBackground,
          todayHighlightColor: colorScheme.primaryContainer.withOpacity(0.3),
          
        ),
        timeLineProps: const EasyTimeLineProps(separatorPadding: 16),
      ),
    );
  }
}
