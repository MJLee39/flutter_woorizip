import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/condition_controller.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/screens/condition/filter_modal.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/text_header_widget.dart';
import 'package:testapp/widgets/client/read_all_widget.dart';

class ConditionReadAllScreen extends GetView<ConditionController> {
  ConditionReadAllScreen({super.key});

  final controller = Get.put(ConditionController());

  @override
  Widget build(BuildContext context) {
    Get.put(ConditionController());
    controller.readAllCondition();

    return Scaffold(
      appBar: const AppBarWidget(),
      body: PageNormalPaddingWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            const TextHeaderWidget(text: '근방의 의뢰인들이 등록한 조건들이에요'),

            const SizedBox(height: 20),

            // 조건 필터
            const FilterModal(),

            const SizedBox(height: 20),

            // 조건 전체 조회
            ReadAllWidget(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
