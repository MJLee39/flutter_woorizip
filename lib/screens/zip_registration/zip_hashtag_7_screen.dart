import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/zip_registration_controller.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/widgets/zip/select_hashtag_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/text_header_widget.dart';
import 'package:testapp/widgets/bottom_expend_button_widget.dart';

class ZipHashtagScreen extends GetView<ZipRegistration> {
  const ZipHashtagScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final ZipRegistration zipRegistration = Get.put(ZipRegistration());

    return Scaffold(
      appBar: const AppBarWidget(),
      body: PageNormalPaddingWidget(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextHeaderWidget(text: "매물의 옵션 정보를 입력해주세요"),
              const SizedBox(height: 30),
              // select hashtag
              SelectHashtagWidget(controller: zipRegistration), // 컨트롤러 전달
              const SizedBox(height: 40),
              // 화면이동 버튼
              BottomExpendButtonWidget(
                text: '등록',
                url: '/zip_hashtag',
                arguments: {},
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
