import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/utils/app_colors.dart';
import 'package:testapp/controllers/zip_registration_controller.dart'; // 컨트롤러 임포트

class RigisterButtonWidget extends StatelessWidget {
  final String text;
  final String url;
  final dynamic arguments;
  final VoidCallback? onPressed; // onPressed 콜백 추가

  const RigisterButtonWidget({
    super.key,
    required this.text,
    required this.url,
    this.arguments,
    this.onPressed, // onPressed 파라미터 추가
  });

  @override
  Widget build(BuildContext context) {
    final ZipRegistration controller = Get.find<ZipRegistration>(); // 컨트롤러 찾기

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
          if (onPressed != null) {
            onPressed!(); // onPressed 콜백 호출
          }
          Get.toNamed(url, arguments: arguments);
        },
        child: Text(
          text,
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