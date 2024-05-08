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

import '../../widgets/zip/update_button_widget.dart';

class ZipDetailRegistrationScreen extends StatelessWidget {
  final ZipRegistration controller = Get.find<ZipRegistration>();

  @override
  Widget build(BuildContext context) {
    debugPrint('5-location: ${controller.location}');
    debugPrint('5-estate: ${controller.estate}');
    debugPrint('5-attechement: ${controller.attachments}');
    debugPrint('5-total floor: ${controller.total_floor}');
    debugPrint('5-deposit: ${controller.deposit}');
    debugPrint('5-fee: ${controller.fee}');
    debugPrint('5-maintenance_fee: ${controller.maintenance_fee}');

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
            UpdateButtonWidget(
              text: '다음',
              onPressed: () {
                // TextField가 비어 있는지 확인하여 메시지 출력
                if (controller.buildingType == '' ||
                    controller.direction == '' ||
                    controller.moveInDate == '') {
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
                  Navigator.pushNamed(context, '/detail_registration5_5');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}