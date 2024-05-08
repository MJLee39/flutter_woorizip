import 'package:flutter/material.dart';
import 'package:testapp/controllers/zip_registration_controller.dart';
import 'package:get/get.dart';
import 'package:testapp/widgets/text_header_widget.dart';
import 'package:testapp/widgets/bottom_expend_button_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/zip/checked_at_widget.dart';
import 'package:testapp/widgets/zip/select_hashtag_widget.dart';
import 'package:testapp/widgets/app_bar_widget.dart';

import '../../widgets/zip/update_button_widget.dart';

class ZipDetailRegistrationNextScreen extends StatelessWidget {
  final ZipRegistration controller = Get.find<ZipRegistration>();

  @override
  Widget build(BuildContext context) {
    debugPrint('6-location: ${controller.location}');
    debugPrint('6-estate: ${controller.estate}');
    debugPrint('6-attechement: ${controller.attachments}');
    debugPrint('6-total floor: ${controller.total_floor}');
    debugPrint('6-deposit: ${controller.deposit}');
    debugPrint('6-fee: ${controller.fee}');
    debugPrint('6-maintenance_fee: ${controller.maintenance_fee}');
    debugPrint('6-buildingType: ${controller.buildingType}');
    debugPrint('6-direction: ${controller.direction}');
    debugPrint('6-moveInDate: ${controller.moveInDate}');
    debugPrint('6-room: ${controller.room}');
    debugPrint('6-toilet: ${controller.toilet}');
    debugPrint('6-m2: ${controller.m2}');

    return Scaffold(
      appBar: const AppBarWidget(),
      body: PageNormalPaddingWidget(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextHeaderWidget(text: "매물 정보를 확인하신 날을 알려주세요"),
                    SizedBox(height: 10),
                    CheckedAtWidget(),
                    SizedBox(height: 40),
                    TextHeaderWidget(text: "메모를 남겨주세요(비공개용)"),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              labelText: '메모',
                            ),
                            onChanged: (value) {
                              controller.note = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    TextHeaderWidget(text: "매물의 공개 여부를 선택해주세요"),
                    Obx(() => Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: controller.showYes.value == 'public' ? Colors.blue : Colors.grey, // 공개 상태일 때 파란색, 아닐 때 회색
                              textStyle: TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            onPressed: () {
                              // 선택된 값이 공개로 설정됨
                              controller.showYes.value = 'public';
                            },
                            child: Text('공개'),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: controller.showYes.value == 'private' ? Colors.blue : Colors.grey, // 비공개 상태일 때 파란색, 아닐 때 회색
                              textStyle: TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            onPressed: () {
                              // 선택된 값이 비공개로 설정됨
                              controller.showYes.value = 'private';
                            },
                            child: Text('비공개'),
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ),
            UpdateButtonWidget(
              text: '다음',
              onPressed: () {
                // TextField가 비어 있는지 확인하여 메시지 출력
                if (controller.checked_at == '' ||
                    controller.showYes == '') {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('정보를 모두 입력해주세요'),
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
                  Navigator.pushNamed(context, '/zip_hashtag');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}