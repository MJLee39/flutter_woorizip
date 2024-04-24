import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:testapp/controllers/zip_registration_controller.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final ZipRegistration controller = Get.find<ZipRegistration>();
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
          setState(() {
            _selectedDate = selectedDate;
          });
          // 선택된 날짜를 controller.moveInDate에 할당
          controller.moveInDate =
              DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
        });
  }
}
