import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/condition_controller.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/screens/condition/filter_modal.dart';
import 'package:testapp/widgets/client/spread_read_by_where.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/text_header_widget.dart';
import 'package:testapp/widgets/client/read_all_widget.dart';

class ConditionReadByWhereScreen extends GetView<ConditionController> {
  ConditionReadByWhereScreen({super.key});

  final ConditionController controller = Get.find<ConditionController>();

  @override
  Widget build(BuildContext context) {
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

            // 조건부 조건 조회 뿌리기
            SpreadReadByWhereWidget(),

          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}