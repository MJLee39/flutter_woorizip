import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/services/auth_service.dart';
import 'package:testapp/services/storage_service.dart';

class ConditionGuard extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      showSnackbar();
    });
    return null; // Returning null to prevent immediate redirection
  }

  void showSnackbar() {
    final MediaQueryData mediaQuery = MediaQuery.of(Get.context!);
    final EdgeInsets viewInsets = mediaQuery.viewInsets;
    final double bottomPadding = mediaQuery.padding.bottom;

    final snackbarHeight = kBottomNavigationBarHeight + 16.0;
    final snackbarMargin = EdgeInsets.only(bottom: snackbarHeight + viewInsets.bottom + bottomPadding);

    Get.snackbar(
      '원하는 매물이 없으신가요?',
      '원하는 매물의 조건을 등록하세요.\n조건에 맞는 물건을 찾아드리겠습니다.',
      snackPosition: SnackPosition.BOTTOM,
      margin: snackbarMargin,
      duration: const Duration(seconds: 5),
      onTap: (_) {
        // When the snackbar is tapped, navigate to the conditionreadone page
        Get.offAllNamed('/conditionreadone');
      },
    );
  }
}
