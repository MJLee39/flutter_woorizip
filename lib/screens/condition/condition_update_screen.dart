import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/condition_controller.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/text_header_widget.dart';

class ConditionUpdateScreen extends GetView<ConditionController> {
  const ConditionUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;

    final TextEditingController idController = TextEditingController(text: arguments['id'] as String?);
    final TextEditingController accountIdController = TextEditingController(text: arguments['accountId'] as String?);
    final TextEditingController locationController = TextEditingController(text: arguments['location'] as String?);
    final TextEditingController buildingTypeController = TextEditingController(text: arguments['buildingType'] as String?);
    final TextEditingController feeController = TextEditingController(text: arguments['fee'].toString());
    final TextEditingController moveInDateController = TextEditingController(text: arguments['moveInDate'] as String?);
    final TextEditingController hashtagController = TextEditingController(text: arguments['hashtag'] as String?);

    Get.put(ConditionController());

    return Scaffold(
      appBar: const AppBarWidget(),
      body: PageNormalPaddingWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const TextHeaderWidget(text: '수정할 내용을 알려주세요'),
            const SizedBox(height: 40),

            // call condition details
            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: '지역',
                border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: buildingTypeController,
              decoration: const InputDecoration(
                labelText: '건물유형',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: feeController,
              decoration: const InputDecoration(
                labelText: '희망금액(만원)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: moveInDateController,
              decoration: const InputDecoration(
                labelText: '입주가능일',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: hashtagController,
              decoration: const InputDecoration(
                labelText: '희망옵션',
                border: OutlineInputBorder(),
              ),
            ),

            const Spacer(),

            // 화면 이동 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    print('** pressed update btn');
                    controller.id = idController.text;
                    print('** got id');
                    controller.accountId = accountIdController.text;
                    print('** got accountId');
                    controller.location = locationController.text;
                    print('** got location');
                    controller.buildingType = buildingTypeController.text;
                    print('** got BT');
                    controller.fee = int.parse(feeController.text);
                    print('** got fee');
                    controller.moveInDate = DateTime.parse(moveInDateController.text);
                    print('** got datetime');
                    controller.hashtag = hashtagController.text;
                    print('** got hashtag');

                    controller.accountId = "accountId01";
                    controller.updateCondition();

                    controller.readAllCondition();

                    Get.toNamed('/conditionreadone');
                  },
                  child: const Text('수정'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }
}