import 'package:flutter/material.dart';
import 'package:testapp/controllers/zip_registration_controller.dart';
import 'package:get/get.dart';
import 'package:testapp/widgets/text_header_widget.dart';
import 'package:testapp/widgets/bottom_expend_button_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/zip/calendar_widget.dart';
import 'package:testapp/widgets/zip/set_buildingtype_buttons_widget.dart';
import 'package:testapp/widgets/zip/direction_zip_buttons_widget.dart';
import 'package:testapp/widgets/app_bar_widget.dart';

class ZipDetailRegistrationScreen extends StatelessWidget {
  final zipRegistration = Get.put(ZipRegistration());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: PageNormalPaddingWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextHeaderWidget(text: "건물 유형을 선택해주세요"),
                    SizedBox(height: 10),
                    SetBuildingtypeButtonsWidget(),
                    SizedBox(height: 30),
                    TextHeaderWidget(text: "거실 기준 건물 방향을 선택해주세요"),
                    DirectionZipButtonsWidget(),
                    SizedBox(height: 30),
                    TextHeaderWidget(text: "입주 가능일을 알려주세요"),
                    SizedBox(height: 10,),
                    CalendarWidget(),
                    SizedBox(height: 30,),
                  ],
                ),
              ),
            ),
            BottomExpendButtonWidget(
              text: '다음',
              url: '/detail_registration5_5',
              arguments: {},
            ),
          ],
        ),
      ),
    );
  }
}