import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime selectedDate = DateTime.now();

    return TableCalendar(
      selectedDayPredicate: (date) => isSameDay(selectedDate, date),
      focusedDay: selectedDate,
      firstDay: DateTime(2020),
      lastDay: DateTime(2030),
      headerStyle: const HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20.0,
        ),
      ),
      onDaySelected: (selectedDate, focusedDate) {
        // Do something when a day is selected
      },
    );
  }
}
