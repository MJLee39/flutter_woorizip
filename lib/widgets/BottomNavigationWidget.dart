import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/NavigationController.dart';
import 'package:testapp/utils/AppColors.dart';

class BottomNavigationWidget extends GetView<NavigationController> {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
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
            icon: Icon(Icons.favorite_border_sharp),
            label: '관심',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: '지도',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline_sharp),
            label: '채팅',
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
            Get.toNamed('/'); // 홈 페이지로 이동
          } else if (index == 1) {
            Get.toNamed('/other'); // 다른 페이지로 이동
          }
          // 필요에 따라 다른 페이지로 이동하는 로직 추가
        },
      ),
    );
  }
}
