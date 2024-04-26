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


class ZipDetailRegistration55Screen extends StatelessWidget {
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
                    TextHeaderWidget(text: "방 수"),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              labelText: '방 수를 입력해주세요',
                            ),
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
                          ),
                        ),
                      ],
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