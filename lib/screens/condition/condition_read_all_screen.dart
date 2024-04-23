import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/condition_read_all_controller.dart';
import 'package:testapp/controllers/condition/set_details_controller.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/text_header_widget.dart';
import 'package:testapp/widgets/client/read_all_widget.dart';

class ConditionReadAllScreen extends GetView<ConditionReadAllController> {
  ConditionReadAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // 이전 페이지에서 받은 데이터 타입을 전부 String으로 변환
    if (arguments != null) {
      final Map<String, String> argumentsAsString = {};
      arguments.forEach((key, value) {
        if (value is DateTime) {
          argumentsAsString[key] = value.toIso8601String();
        } else if (value is int) {
          argumentsAsString[key] = value.toString();
        } else {
          argumentsAsString[key] = value.toString();
        }
      });

      debugPrint('Arguments as String Map: $argumentsAsString');
    }

    final ConditionReadAllController controller =
        Get.put(ConditionReadAllController());

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

            // call read all
            // ReadAllWidget(),

            // 검색 버튼이나 다른 위젯을 추가하세요.
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      Get.toNamed('/setconditiondetail');
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
