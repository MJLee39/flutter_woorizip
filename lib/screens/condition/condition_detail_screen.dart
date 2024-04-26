import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/condition_controller.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/text_header_widget.dart';

class ConditionDetailScreen extends GetView<ConditionController> {
  const ConditionDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: PageNormalPaddingWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const TextHeaderWidget(text: '등록한 조건 단일 조회'),
            const SizedBox(height: 20),

            // call condition details
            // Row(DetailWidget()),

            // 화면이동 버튼
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      Get.toNamed('/updatecondition');
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
