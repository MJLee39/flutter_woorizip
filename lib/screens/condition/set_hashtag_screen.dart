import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/set_details_controller.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/widgets/client/select_hashtag_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/text_header_widget.dart';

class SetHashtagScreen extends GetView<SetDetailsController> {
  const SetHashtagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('Location: ${controller.location.value}');
    debugPrint('Building Type: ${controller.buildingType.value}');
    debugPrint('Fee: ${controller.fee}');
    debugPrint('Move-In Date: ${controller.moveInDate}');
    debugPrint('Hashtag: ${controller.hashtag.value}');

    return Scaffold(
      appBar: const AppBarWidget(),
      body: PageNormalPaddingWidget(
        child: Column(
          children: [
            const TextHeaderWidget(text: '원하는 옵션을 알려주세요'),
            const SizedBox(height: 10),

            // select hashtag
            const SelectHashtagWidget(),

            const SizedBox(height: 20),

            // 화면이동 버튼
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      // Map<String, dynamic> arguments = {
                      //   'accountId': controller.accountId.value,
                      //   'location': controller.location.value,
                      //   'buildingType': controller.buildingType.value,
                      //   'fee': controller.fee,
                      //   'moveInDate': controller.moveInDate,
                      //   'hashtag': controller.hashtag.value,
                      // };
                      // Get.lazyPut(() => SetDetailsController());

                      controller.fetchData();

                      // Get.toNamed('/conditionreadall', arguments: arguments);
                    },
                    child: const Text('확인')),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
