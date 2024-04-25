import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/condition_controller.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/widgets/client/calendar_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/text_header_widget.dart';

class SetMoveInDateScreen extends GetView<ConditionController> {
  const SetMoveInDateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('Location: ${controller.location}');
    debugPrint('Building Type: ${controller.buildingType}');
    debugPrint('Fee: ${controller.fee}');
    debugPrint('Move-In Date: ${controller.moveInDate}');
    debugPrint('Hashtag: ${controller.hashtag}');

    return Scaffold(
      appBar: const AppBarWidget(),
      body: PageNormalPaddingWidget(
        child: Column(
          children: [
            const SizedBox(height: 40,),

            const TextHeaderWidget(text: '입주 가능일을 알려주세요'),

            const SizedBox(height: 20,),

            const CalendarWidget(),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Get.toNamed('/sethashtag');
                  },
                  child: const Text('확인'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
