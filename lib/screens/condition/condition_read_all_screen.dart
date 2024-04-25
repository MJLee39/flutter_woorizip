import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/condition_controller.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/text_header_widget.dart';
import 'package:testapp/widgets/client/read_all_widget.dart';

class ConditionReadAllScreen extends GetView<ConditionController> {
  const ConditionReadAllScreen({super.key});

  // ConditionController controller = Get.find<ConditionController>();

  @override
  Widget build(BuildContext context) {
    // final Map<String, dynamic>? arguments = Get.arguments;

    Get.put(ConditionController());
    controller.readAllCondition();

    return Scaffold(
      appBar: const AppBarWidget(),
      body: PageNormalPaddingWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            const TextHeaderWidget(text: '등록된 조건들이에요'),

            const SizedBox(height: 20),
            // 조건조회(필터) 버튼 추가
            const SizedBox(height: 20),

            const SizedBox(height: 20),

            ReadAllWidget(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
