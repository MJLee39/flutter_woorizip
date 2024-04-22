import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/condition_update_controller.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/text_header_widget.dart';

class ConditionUpdateScreen extends GetView<ConditionUpdateController> {
  const ConditionUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(),
      body: PageNormalPaddingWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            TextHeaderWidget(text: '수정할 내용을 알려주세요'),
            SizedBox(height: 20),

            // call condition details
            Row(),

            // 화면이동 버튼
            Row(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }
}
