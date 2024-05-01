import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testapp/controllers/condition/condition_controller.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/widgets/client/juso_dong_dropdown_widget.dart';
import 'package:testapp/widgets/client/juso_gu_dropdown_widget.dart';
import 'package:testapp/widgets/client/juso_si_dropdown_widget.dart';
import 'package:testapp/widgets/client/set_buildingtype_buttons_widget.dart';
import 'package:testapp/widgets/client/set_fee_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/text_header_widget.dart';
import 'package:get/get.dart';

class SetDetailsScreen extends GetView<ConditionController> {
  const SetDetailsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ConditionController controller = Get.put(ConditionController());

    final RxList<String> locationArray = <String>[].obs;

    return Scaffold(
      appBar: const AppBarWidget(),
      body: PageNormalPaddingWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const TextHeaderWidget(text: '원하는 지역을 알려주세요'),
            const SizedBox(height: 20),

            // selected location: si /gu /dong
            Row(
              children: [
                const Expanded(
                  child: JusoSiDropdownWidget(),
                ),
                const Expanded(
                  child: JusoGuDropdownWidget(),
                ),
                const Expanded(
                  child: JusoDongDropdownWidget(),
                ),
                TextButton(
                  onPressed: () {
                    if (locationArray.length < 3) {
                      String newLocation =
                          '${controller.si} ${controller.gu} ${controller.dong}';
                      print(
                          'new location: ${controller.si} ${controller.gu} ${controller.dong}');
                      locationArray.add(newLocation);
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('위치 목록은 최대 3개까지만 등록할 수 있습니다'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('확인'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.indigo,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('추가'),
                ),
              ],
            ),

            // 선택된 location 출력(최대 3개)
            SizedBox(
              height: 120,
              child: Obx(() {
                return Column(
                  children: locationArray.map((location) {
                    return Row(
                      children: [
                        Expanded(
                          child: Text(
                            location,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.grey),
                          onPressed: () {
                            locationArray.remove(location);
                          },
                        ),
                      ],
                    );
                  }).toList(),
                );
              }),
            ),

            const SizedBox(height: 80),

            const TextHeaderWidget(text: '원하는 건물 유형을 알려주세요'),

            const SizedBox(height: 20),

            // set building type
            const Row(children: [SetBuildingtypeButtonsWidget()]),

            const SizedBox(height: 80),

            const TextHeaderWidget(text: '희망 가격대를 알려주세요'),

            const SizedBox(height: 20),

            // set fee
            Row(children: [SetFeeWidget()]),

            const Spacer(),

            // 화면이동 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    // 지역과 건물 유형이 선택되지 않은 경우 알림 창 표시
                    if (locationArray.isEmpty ||
                        controller.buildingType == '') {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('필수조건 누락!'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('입력하러 가기'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      controller.location = locationArray.join(', ');
                      Get.toNamed('/setmoveindate');
                    }
                  },
                  child: const Text('확인'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
