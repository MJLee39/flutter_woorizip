import 'package:flutter/material.dart';
import 'package:testapp/widgets/client/number_input_widget.dart';
import 'package:testapp/controllers/zip_registration_controller.dart';
import 'package:get/get.dart';
import 'package:testapp/widgets/text_header_widget.dart';
import 'package:testapp/widgets/bottom_expend_button_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/zip/calendar_widget.dart';

class ZipDetailRegistrationScreen extends StatelessWidget {

  final zipRegistration = Get.put(ZipRegistration());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const TextHeaderWidget(text: "상세 정보를 알려주세요"),
      ),
      body: PageNormalPaddingWidget(
        child: Column(
          children: [
            Text("입주 가능일을 알려주세요"),
            const SizedBox(height: 10,),

            CalendarWidget(), // CalendarWidget에 Expanded 추가
            SizedBox(height: 20,),
            // 방 입력 필드
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("방 수:"),
                  SizedBox(width: 34,),
                  Expanded(
                    child: NumberInputWidget(
                      onChanged: (int? newValue) {

                      },
                    ),
                  ),
                ],
              ),
            ),
            // 화장실 입력 필드
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("화장실 수:"),
                  SizedBox(width: 10,),
                  Expanded(
                    child: NumberInputWidget(
                      onChanged: (int? newValue) {

                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  children: [

                  ],
              ),
            ),
            // 다음 버튼
            BottomExpendButtonWidget(
              text: '다음',
              url: '/detail_registration2',
              arguments: {
                // 'deposit': zipDetailRegistration.deposit,
                // 'fee': zipDetailRegistration.fee,
              },
            ),
          ],
        ),
      ),
    );
  }
}
