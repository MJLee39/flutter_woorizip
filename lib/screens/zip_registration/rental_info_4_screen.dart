import 'package:flutter/material.dart';
import 'package:testapp/widgets/client/number_input_widget.dart';
import 'package:testapp/controllers/zip_registration_controller.dart';
import 'package:get/get.dart';
import 'package:testapp/widgets/text_header_widget.dart';
import 'package:testapp/widgets/bottom_expend_button_widget.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';

import '../../widgets/zip/rigister_buttons_widget.dart';
import '../../widgets/zip/update_button_widget.dart';

class RentalInfoScreen extends StatelessWidget {
  final ZipRegistration controller = Get.find<ZipRegistration>();

  @override
  Widget build(BuildContext context) {
    debugPrint('4-location: ${controller.location}');
    debugPrint('4-estate: ${controller.estate}');
    debugPrint('4-attechement: ${controller.attachments}');
    debugPrint('4-total floor: ${controller.total_floor}');
    debugPrint('4-building floor: ${controller.building_floor}');
    return Scaffold(
      appBar: const AppBarWidget(),
      body: PageNormalPaddingWidget(
        child: Column(
          children: [
            TextHeaderWidget(text: "보증금, 월세, 관리비를 입력해주세요"),
            // 보증금 입력 필드
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: '보증금을 만원 단위로 입력하세요',
                    ),
                    onChanged: (value) {
                      controller.deposit = int.tryParse(value) ?? 0;
                    },
                    keyboardType: TextInputType.number, // Only accept numeric
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
                    onChanged: (value) {
                      controller.fee = int.tryParse(value) ?? 0;
                    },
                    keyboardType: TextInputType.number, // Only accept numeric
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: '관리비를 만원 단위로 입력하세요',
                    ),
                    onChanged: (value) {
                      controller.maintenance_fee = double.tryParse(value) ?? 0;
                    },
                    keyboardType: TextInputType.number, // Only accept numeric
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            // 다음 버튼
            UpdateButtonWidget(
              text: '다음',
              onPressed: () {
                // TextField가 비어 있는지 확인하여 메시지 출력
                if (controller.deposit == 0 ||
                    controller.fee == 0 ||
                    controller.maintenance_fee == 0) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('숫자로 모두 입력해주세요'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('확인'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // 다음 화면으로 이동
                  Navigator.pushNamed(context, '/detail_registration');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}