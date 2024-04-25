import 'package:flutter/material.dart';
import 'package:testapp/controllers/zip_registration_controller.dart';
import 'package:get/get.dart';
import 'package:testapp/widgets/text_header_widget.dart';
import 'package:testapp/widgets/bottom_expend_button_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/zip/calendar_widget.dart';
import 'package:testapp/widgets/zip/set_buildingtype_buttons_widget.dart';
import 'package:testapp/widgets/zip/direction_zip_buttons_widget.dart';

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("건물 유형을 선택해주세요"),
                    SizedBox(height: 10),
                    SetBuildingtypeButtonsWidget(),
                    SizedBox(height: 30),
                    Text("거실 기준 건물 방향을 선택해주세요"),
                    DirectionZipButtonsWidget(),
                    SizedBox(height: 30),
                    Text("입주 가능일을 알려주세요"),
                    SizedBox(height: 10,),
                    CalendarWidget(),
                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("방 수:"),
                          SizedBox(width: 34,),
                          Expanded(
                            child: TextFormField(
                              onChanged: (value) {
                                // onChanged 이벤트 핸들러
                              },
                              decoration: InputDecoration(
                                hintText: '방 수를 입력하세요',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("화장실 수:"),
                          SizedBox(width: 10,),
                          Expanded(
                            child: TextFormField(
                              onChanged: (value) {
                                // onChanged 이벤트 핸들러
                              },
                              decoration: InputDecoration(
                                hintText: '화장실 수를 입력하세요',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("공급 면적:"),
                          SizedBox(width: 10,),
                          Expanded(
                            child: TextFormField(
                              onChanged: (value) {
                                // onChanged 이벤트 핸들러
                              },
                              decoration: InputDecoration(
                                hintText: '공급 면적을 입력하세요',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BottomExpendButtonWidget(
              text: '다음',
              url: '/detail_registration2',
              arguments: {},
            ),
          ],
        ),
      ),
    );
  }
}