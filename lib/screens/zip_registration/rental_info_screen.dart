import 'package:flutter/material.dart';
import 'package:testapp/widgets/client/number_input_widget.dart';
import 'package:testapp/controllers/zip_registration_controller.dart';
import 'package:get/get.dart';
import 'package:testapp/widgets/text_header_widget.dart';
import 'package:testapp/widgets/bottom_expend_button_widget.dart';
import 'package:testapp/controllers/zip_registration_controller.dart';

class RentalInfoScreen extends StatelessWidget {

  final ZipRegistration zipRegistration = Get.find(); // Access the ZipRegistration controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextHeaderWidget(text: "보증금과 월세를 입력해주세요"),
      ),
      body: Column(
        children: [
          // 보증금 입력 필드
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("보증금:"),
                SizedBox(width: 10,),
                Expanded(
                  child: TextFormField(
                    onChanged: (value) {
                      // onChanged 이벤트 핸들러
                    },
                    decoration: InputDecoration(
                      hintText: '보증금을 입력하세요',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 월세 입력 필드
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("월세:"),
                SizedBox(width: 22,),
                Expanded(
                  child: TextFormField(
                    onChanged: (value) {
                      // onChanged 이벤트 핸들러
                    },
                    decoration: InputDecoration(
                      hintText: '월세를 입력하세요',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
    );
  }
}