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
    print('location: ' + controller.location.value);
    print('buildingType: ' + controller.buildingType.value);
    print(controller.fee);
    print(controller.moveInDate);
    print('hashtag: ' + controller.hashtag.value);

    return Scaffold(
      appBar: const AppBarWidget(),
      body: PageNormalPaddingWidget(
        child: Column(
          children: [
            const TextHeaderWidget(text: '입주 가능일을 알려주세요'),
            const SizedBox(
              height: 10,
            ),
            const CalendarWidget(),
            // 화면이동 버튼
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      Map<String, dynamic> arguments = {
                        'location': controller.location.value,
                        'buildingType': controller.buildingType.value,
                        'fee': controller.fee,
                        'moveInDate': controller.moveInDate,
                        'hashtag': controller.hashtag.value,
                      };

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
