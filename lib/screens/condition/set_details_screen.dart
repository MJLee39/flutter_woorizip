import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:testapp/controllers/condition/set_details_controller.dart';
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

class SetDetailsScreen extends GetView<SetDetailsController> {
  const SetDetailsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(SetDetailsController());
    return Scaffold(
      appBar: const AppBarWidget(),
      body: PageNormalPaddingWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          // set details
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
                )
              ],
            ),

            const SizedBox(height: 40),

            const TextHeaderWidget(text: '건물 유형을 알려주세요'),

            const SizedBox(height: 20),

            //set building type
            const Row(children: [SetBuildingtypeButtonsWidget()]),

            const SizedBox(height: 40),

            const TextHeaderWidget(text: '희망 가격대를 알려주세요'),

            const SizedBox(height: 20),

            // set fee
            Row(children: [SetFeeWidget()]),

            const SizedBox(height: 40),

            // 화면이동 버튼
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      // 지역과 건물 유형이 선택되지 않은 경우 알림 창 표시
                      if (controller.buildingType.value == '') {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('필수조건 누락!'),
                              content: Text('건물 유형을 알려주세요'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('입력하러 가기'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        String si = controller.si.value;
                        String gu = controller.gu.value;
                        String dong = controller.dong.value;
                        controller.location.value = si + gu + dong;

                        // 필수 조건이 선택된 경우 다음 화면으로 이동
                        // Map<String, dynamic> arguments = {
                        //   'accountId': controller.accountId.value,
                        //   'location': controller.location.value,
                        //   'buildingType': controller.buildingType.value,
                        //   'fee': controller.fee,
                        //   'moveInDate': controller.moveInDate,
                        //   'hashtag': controller.hashtag.value,
                        // };

                        // accountId

                        Get.toNamed('/setmoveindate');
                      }
                    },
                    child: Text('확인')),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
