import 'package:flutter/material.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/widgets/client/calendar_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/text_header_widget.dart';

class SetMoveInDateScreen extends StatelessWidget {
  const SetMoveInDateScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return const Scaffold(
     appBar: AppBarWidget(),
     body: PageNormalPaddingWidget(
       child: Column(
         children: [
           TextHeaderWidget(text: '입주 가능일을 알려주세요'),
           SizedBox(height: 10,),
           CalendarWidget(),
         ],
       ),
     ),
     bottomNavigationBar: BottomNavigationWidget(),
   );
}
}
