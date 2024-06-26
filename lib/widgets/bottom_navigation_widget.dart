import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/account/account_controller.dart';
import 'package:testapp/controllers/navigation_controller.dart';
import 'package:testapp/utils/app_colors.dart';

class BottomNavigationWidget extends GetView<NavigationController> {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AccountController _accountController = AccountController();

    return Obx(
      () => ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.mainColorTest,
          unselectedItemColor: Colors.grey[400],
          currentIndex: controller.currentIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: '지도',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline_sharp),
              label: '메시지',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: '더보기',
            ),
          ],
          onTap: (index) {
            controller.currentIndex = index;
            print(index);

            if (index == 0) {
              Get.offAllNamed('/'); // 홈 페이지로 이동
            } else if (index == 1) {
              Get.toNamed('/map/total');
            } else if (index == 2) {
              Get.toNamed('/chatRoomList', arguments: {
                'accountId': _accountController.id,
              });
            } else if (index == 3) {
              Get.offAllNamed('/seeMore'); // '더보기' 페이지로 이동
            }
          },
        ),
      ),
    );
  }
}