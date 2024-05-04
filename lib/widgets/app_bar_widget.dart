import 'package:flutter/material.dart';
import 'package:testapp/utils/app_colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key, this.title});
  // optional title null ok
  final String? title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null ? Text(title!, style: TextStyle(
        color: AppColors.mainColorTest,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),) : null,
      backgroundColor: Colors.white,
      elevation: 0,
      foregroundColor: AppColors.mainColorTest,
      // 기타 AppBar 속성 추가
    );
  }
}