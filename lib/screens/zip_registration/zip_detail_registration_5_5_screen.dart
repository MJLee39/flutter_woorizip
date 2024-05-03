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


class ZipDetailRegistration55Screen extends StatelessWidget {
  final ZipRegistration controller = Get.find<ZipRegistration>();

  @override
  Widget build(BuildContext context) {
    debugPrint('5.5-location: ${controller.location}');
    debugPrint('5.5-estate: ${controller.estate}');
    debugPrint('5.5-attechement: ${controller.attachments}');
    debugPrint('5.5-total floor: ${controller.total_floor}');
    debugPrint('5.5-deposit: ${controller.deposit}');
    debugPrint('5.5-fee: ${controller.fee}');
    debugPrint('5.5-maintenance_fee: ${controller.maintenance_fee}');
    debugPrint('5.5-buildingType: ${controller.buildingType}');
    debugPrint('5.5-direction: ${controller.direction}');
    debugPrint('5.5-moveInDate: ${controller.moveInDate}');

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
                    TextHeaderWidget(text: "방 수"),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              labelText: '방 수를 입력해주세요',
                            ),
                            onChanged: (value) {
                              controller.room = int.tryParse(value) ?? 0;
                            },
                            keyboardType: TextInputType.number, // Only accept numeric
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40,),
                    TextHeaderWidget(text: "화장실 수"),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              labelText: '화장실 수를 입력하세요',
                            ),
                            onChanged: (value) {
                              controller.toilet = int.tryParse(value) ?? 0;
                            },
                            keyboardType: TextInputType.number, // Only accept numeric
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40,),
                    TextHeaderWidget(text: "공급 면적"),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              labelText: '공급 면적을 입력하세요',
                            ),
                            onChanged: (value) {
                              controller.m2 = double.tryParse(value) ?? 0;
                            },
                            keyboardType: TextInputType.number, // Only accept numeric
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            UpdateButtonWidget(
              text: '다음',
              onPressed: () {
                // TextField가 비어 있는지 확인하여 메시지 출력
                if (controller.room == 0 ||
                    controller.toilet == 0 ||
                    controller.m2 == 0) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('모두 숫자로 입력해주세요'),
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
                  Navigator.pushNamed(context, '/detail_registration2');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}