import 'package:flutter/material.dart';
import 'package:testapp/utils/app_colors.dart';

class TextHeaderWidget extends StatelessWidget {
  final String text; // String 타입의 파라미터 추가

  const TextHeaderWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text, // 변수를 사용하여 Text 위젯의 내용 설정
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.mainColorTest,
            decoration: TextDecoration.underline,
            decorationColor: Colors.white,
            decorationThickness: 0,
          ),
        ),
      ],
    );
  }
}