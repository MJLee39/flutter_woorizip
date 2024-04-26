import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/utils/app_colors.dart';

class BottomExpendButtonWidget extends StatelessWidget {
  final String text;
  final String url;
  final dynamic arguments;

  const BottomExpendButtonWidget({
    super.key,
    required this.text,
    required this.url,
    this.arguments,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 0,
      right: 0,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: AppColors.mainColorTest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: const Size(double.infinity, 60),
        ),
        onPressed: () {
          Get.toNamed(url, arguments: arguments);
          // 결과 페이지로 이동
        },
        child: Text(text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
