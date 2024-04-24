import 'package:flutter/material.dart';
import 'package:testapp/widgets/client/number_input_widget.dart';
import 'package:testapp/controllers/zip_registration_controller.dart';
import 'package:get/get.dart';
import 'package:testapp/widgets/text_header_widget.dart';
import 'package:testapp/widgets/bottom_expend_button_widget.dart';

class RentalInfoScreen extends StatelessWidget {

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
                  child: NumberInputWidget(
                    onChanged: (int? newValue) {

                    },
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
                  child: NumberInputWidget(
                    onChanged: (int? newValue) {

                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}