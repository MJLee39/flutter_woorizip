import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/services/auth_service.dart';
import 'package:testapp/services/storage_service.dart';

class ConditionGuard extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    Get.snackbar(
      '원하는 매물이 없으신가요?',
      '원하는 매물의 조건을 등록할 수 있습니다.\n조건에 맞는 물건을 찾으면 연락드리겠습니다.',
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.only(bottom: kBottomNavigationBarHeight + 16.0), // Adjust margin to position above bottom navigation bar
      duration: const Duration(seconds: 5),
      onTap: (snackbar) {
        // When the snackbar is tapped, navigate to the conditionreadone page
        Get.offAllNamed('/conditionreadone');
      },
    );
    return null; // Returning null to prevent immediate redirection
  }
}
