import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/set_details_controller.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/widgets/client/calendar_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/text_header_widget.dart';

class SetMoveInDateScreen extends GetView<SetDetailsController> {
  const SetMoveInDateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('Location: ${controller.location.value}');
    debugPrint('Building Type: ${controller.buildingType.value}');
    debugPrint('Fee: ${controller.fee}');
    debugPrint('Move-In Date: ${controller.moveInDate}');
    debugPrint('Hashtag: ${controller.hashtag.value}');

    return Scaffold(
      appBar: const AppBarWidget(),
      body: PageNormalPaddingWidget(
        child: Column(
          children: [
            const TextHeaderWidget(text: '입주 가능일을 알려주세요'),
            const SizedBox(
              height: 10,
            ),

            // 달력의 날짜 선택 시 선택된 날짜를 moveInDate에 저장
            const CalendarWidget(),

            // 화면이동 버튼
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      Get.toNamed('/sethashtag');
                    },
                    child: const Text('확인')),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
