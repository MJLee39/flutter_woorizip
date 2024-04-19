import 'package:flutter/material.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/widgets/client/calendar_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/text_header_widget.dart';

class SetMoveInDateScreen extends StatefulWidget {
  const SetMoveInDateScreen({super.key});

  @override
  _SetMoveInDateScreenState createState() => _SetMoveInDateScreenState();
}

class _SetMoveInDateScreenState extends State<SetMoveInDateScreen> {
  // LocalDate 대신 DateTime 타입 변수
  DateTime _selectedDate = DateTime.now(); // 초기값을 현재 날짜로 설정

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(),
      body: PageNormalPaddingWidget(
        child: Column(
          children: [
            TextHeaderWidget(text: '입주 가능일을 알려주세요'),
            SizedBox(
              height: 10,
            ),
            CalendarWidget(
                // onDateSelected: (DateTime selectedDate) {
                //   setState(() {
                //     _selectedDate = selectedDate;
                //   });
                // },
                ),
            // 화면이동 버튼
            Row(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
