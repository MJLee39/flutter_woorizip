import 'package:flutter/material.dart';
import 'package:testapp/utils/AppColors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      foregroundColor: AppColors.mainColorTest,
      // 기타 AppBar 속성 추가
    );
  }
}