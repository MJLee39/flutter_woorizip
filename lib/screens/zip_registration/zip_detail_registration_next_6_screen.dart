import 'package:flutter/material.dart';
import 'package:testapp/controllers/zip_registration_controller.dart';
import 'package:get/get.dart';
import 'package:testapp/widgets/text_header_widget.dart';
import 'package:testapp/widgets/bottom_expend_button_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/zip/checked_at_widget.dart';
import 'package:testapp/widgets/zip/select_hashtag_widget.dart';

class ZipDetailRegistrationNextScreen extends StatelessWidget {
  final zipRegistration = Get.put(ZipRegistration());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextHeaderWidget(text: "기타 정보를 알려주세요"),
      ),
      body: PageNormalPaddingWidget(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("매물 정보를 확인하신 날을 알려주세요"),
                    SizedBox(height: 10),
                    CheckedAtWidget(),
                    SizedBox(height: 30),
                    Text("메모를 남겨주세요. 이 정보는 비공개 됩니다."),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (value) {
                          // onChanged 이벤트 핸들러
                        },
                        decoration: InputDecoration(
                          hintText: '메모',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
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