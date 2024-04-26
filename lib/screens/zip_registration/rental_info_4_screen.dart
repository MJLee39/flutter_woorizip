import 'package:flutter/material.dart';
import 'package:testapp/widgets/client/number_input_widget.dart';
import 'package:testapp/controllers/zip_registration_controller.dart';
import 'package:get/get.dart';
import 'package:testapp/widgets/text_header_widget.dart';
import 'package:testapp/widgets/bottom_expend_button_widget.dart';
import 'package:testapp/controllers/zip_registration_controller.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';

class RentalInfoScreen extends StatelessWidget {

  final ZipRegistration zipRegistration = Get.find(); // Access the ZipRegistration controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: PageNormalPaddingWidget(
        child: Column(
          children: [
            TextHeaderWidget(text: "보증금과 월세를 입력해주세요"),
            // 보증금 입력 필드
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: '보증금을 만원 단위로 입력하세요',
                    ),
                  ),
                ),
              ],
            ),
            // 월세 입력 필드
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: '월세를 만원 단위로 입력하세요',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40,),
            // 다음 버튼
            BottomExpendButtonWidget(
              text: '다음',
              url: '/detail_registration',
              arguments: {
                'deposit': zipRegistration.deposit,
                'fee': zipRegistration.fee,
              },
            ),
          ],
        ),
      ),
    );
  }
}