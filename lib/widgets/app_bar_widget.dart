import 'package:flutter/material.dart';
import 'package:testapp/utils/app_colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key, this.title, this.actions});

  // optional title null ok
  final String? title;

  // optional actions null ok
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null
          ? Text(
              title!,
              style: const TextStyle(
                color: AppColors.mainColorTest,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
      backgroundColor: Colors.white,
      elevation: 0, // 그림자 크기 조절
      shadowColor: Colors.grey[200], // 연한 회색 그림자 색상
      foregroundColor: AppColors.mainColorTest, // 기타 AppBar 속성 추가
      actions: actions, // 선택적으로 받은 actions 추가
    );
  }
}