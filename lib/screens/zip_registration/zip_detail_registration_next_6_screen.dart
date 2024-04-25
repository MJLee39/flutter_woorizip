import 'package:flutter/material.dart';
import 'package:testapp/controllers/zip_registration_controller.dart';
import 'package:get/get.dart';
import 'package:testapp/widgets/text_header_widget.dart';
import 'package:testapp/widgets/bottom_expend_button_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/zip/checked_at_widget.dart';
import 'package:testapp/widgets/zip/select_hashtag_widget.dart';
import 'package:testapp/widgets/app_bar_widget.dart';

class ZipDetailRegistrationNextScreen extends StatelessWidget {
  final zipRegistration = Get.put(ZipRegistration());

  @override
  Widget build(BuildContext context) {
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
                    TextHeaderWidget(text: "메모를 남겨주세요. 이 정보는 비공개 됩니다."),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              labelText: '메모',
                            ),
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
                              backgroundColor: zipRegistration.showYes.value == 'public' ? Colors.blue : Colors.grey, // 공개 상태일 때 파란색, 아닐 때 회색
                              textStyle: TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            onPressed: () {
                              // 선택된 값이 공개로 설정됨
                              zipRegistration.showYes.value = 'public';
                            },
                            child: Text('공개'),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: zipRegistration.showYes.value == 'private' ? Colors.blue : Colors.grey, // 비공개 상태일 때 파란색, 아닐 때 회색
                              textStyle: TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            onPressed: () {
                              // 선택된 값이 비공개로 설정됨
                              zipRegistration.showYes.value = 'private';
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
            BottomExpendButtonWidget(
              text: '다음',
              url: '/zip_hashtag',
              arguments: {},
            ),
          ],
        ),
      ),
    );
  }
}