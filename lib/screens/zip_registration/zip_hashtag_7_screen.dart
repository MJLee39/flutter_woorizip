import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/zip_registration_controller.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/widgets/zip/select_hashtag_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/text_header_widget.dart';
import 'package:testapp/widgets/zip/rigister_buttons_widget.dart';

class ZipHashtagScreen extends GetView<ZipRegistration> {
  const ZipHashtagScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final ZipRegistration controller = Get.find<ZipRegistration>();
    debugPrint('7-location: ${controller.location}');
    debugPrint('7-estate: ${controller.estate}');
    debugPrint('7-attechement: ${controller.attachments}');
    debugPrint('7-total floor: ${controller.total_floor}');
    debugPrint('7-deposit: ${controller.deposit}');
    debugPrint('7-fee: ${controller.fee}');
    debugPrint('7-maintenance_fee: ${controller.maintenance_fee}');
    debugPrint('7-buildingType: ${controller.buildingType}');
    debugPrint('7-direction: ${controller.direction}');
    debugPrint('7-moveInDate: ${controller.moveInDate}');
    debugPrint('7-room: ${controller.room}');
    debugPrint('7-toilet: ${controller.toilet}');
    debugPrint('7-m2: ${controller.m2}');
    debugPrint('7-checked_at: ${controller.checked_at}');
    debugPrint('7-note: ${controller.note}');
    debugPrint('7-showYes: ${controller.showYes}');

    return Scaffold(
      appBar: const AppBarWidget(),
      body: PageNormalPaddingWidget(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextHeaderWidget(text: "매물의 옵션 정보를 입력해주세요"),
              const SizedBox(height: 30),
              // select hashtag
              SelectHashtagWidget(), // 컨트롤러 전달
              const SizedBox(height: 40),
              // 화면이동 버튼
              RigisterButtonWidget(
                text: '등록',
                url: '', //detailpage로 연결하기
                onPressed: () {
                  controller.updateValues(
                    location: '${controller.location}',
                    estate: '${controller.estate}',
                    attachments: '${controller.attachments}',
                    building_floor: int.tryParse('${controller.building_floor}'),
                    totalFloor: int.tryParse('${controller.total_floor}') ?? 0,
                    deposit: int.tryParse('${controller.deposit}') ?? 0,
                    fee: int.tryParse('${controller.fee}') ?? 0,
                    maintenanceFee: double.tryParse('${controller.maintenance_fee}') ?? 0,
                    buildingType: '${controller.buildingType}',
                    direction: '${controller.direction}',
                    moveInDate: DateTime.parse('${controller.moveInDate}'),
                    room: int.tryParse('${controller.room}') ?? 0,
                    toilet: int.tryParse('${controller.toilet}') ?? 0,
                    m2: double.tryParse('${controller.m2}') ?? 0,
                    checkedAt: DateTime.parse('${controller.checked_at}'),
                    note: '${controller.note}',
                    showYes: '${controller.showYes}',
                    hashtag: '${controller.hashtag}'
                  );
                  controller.saveZip();
                  Get.snackbar(
                    "알림",
                    "매물이 등록되었습니다",
                    snackPosition: SnackPosition.BOTTOM, // 스낵바 위치 설정
                    colorText: Colors.white, // 텍스트 색상 설정
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
