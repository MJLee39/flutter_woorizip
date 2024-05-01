import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/condition_controller.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/widgets/client/select_hashtag_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/text_header_widget.dart';

class SetHashtagScreen extends GetView<ConditionController> {
  const SetHashtagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('Location: ${controller.location}');
    debugPrint('Building Type: ${controller.buildingType}');
    debugPrint('Location: ${controller.location}');
    debugPrint('Building Type: ${controller.buildingType}');
    debugPrint('Fee: ${controller.fee}');
    debugPrint('Move-In Date: ${controller.moveInDate}');
    debugPrint('Hashtag: ${controller.hashtag}');
    debugPrint('Hashtag: ${controller.hashtag}');

    return Scaffold(
      appBar: const AppBarWidget(),
      body: PageNormalPaddingWidget(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            const TextHeaderWidget(text: '원하는 옵션을 알려주세요'),
            const SizedBox(height: 40),

            // select hashtag
            const SelectHashtagWidget(),

            const SizedBox(height: 40),

            // 화면이동 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    controller.saveCondition();
                    Navigator.pushNamed(context, '/conditionreadone');
                  },
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.indigo),
                  ),
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
