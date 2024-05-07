import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:testapp/controllers/condition/condition_controller.dart';

class CalendarWidget extends StatefulWidget {
  final Function(DateTime)? onChanged;
  const CalendarWidget({super.key, this.onChanged});

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final ConditionController controller = Get.find<ConditionController>();
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
        selectedDayPredicate: (date) => isSameDay(_selectedDate, date),
        focusedDay: _selectedDate,
        firstDay: DateTime.now(),
        lastDay: DateTime(2100),
        headerStyle: const HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20.0,
          ),
        ),
        onDaySelected: (selectedDate, focusedDate) {
          if (widget.onChanged != null) {
            widget.onChanged!(selectedDate);
          }

          setState(() {
            _selectedDate = selectedDate;
          });
          controller.moveInDate =
              DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
        }
    );
  }
}
