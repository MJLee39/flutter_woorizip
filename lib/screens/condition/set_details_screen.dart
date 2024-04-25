import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
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
    Get.put(ConditionController());
    return Scaffold(
      appBar: const AppBarWidget(),
      body: PageNormalPaddingWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            const SizedBox(height: 20),
            const TextHeaderWidget(text: '원하는 지역을 알려주세요'),
            const SizedBox(height: 20),

            // set location: si /gu /dong
            const Row(
              children: [
                Expanded(
                  child: JusoSiDropdownWidget(),
                ),
                Expanded(
                  child: JusoGuDropdownWidget(),
                ),
                Expanded(
                  child: JusoDongDropdownWidget(),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     print(controller.si + " " + controller.gu + " " + controller.dong);
                //   },
                //   child: const Text('고르기'),
                // ),
              ],
            ),


            const SizedBox(height: 80),

            //set building type
            const TextHeaderWidget(text: '원하는 건물 유형을 알려주세요'),

            const SizedBox(height: 20),

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
                    if (controller.buildingType == '') {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('필수조건 누락!'),
                            content: const Text('건물 유형을 알려주세요'),
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
                      String si = controller.si;
                      String gu = controller.gu;
                      String dong = controller.dong;
                      controller.location = si + gu + dong;

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
