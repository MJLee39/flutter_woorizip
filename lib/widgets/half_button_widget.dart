import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HalfButtonWidget extends StatelessWidget {
  final String text; // String 타입의 파라미터 추가
  final String imagePath;
  final String urlPath;
  final String? additionalArgument; // 추가적인 인자
  const HalfButtonWidget({super.key, required this.text, required this.imagePath, required this.urlPath, this.additionalArgument});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          Get.toNamed(urlPath, arguments: additionalArgument);
          // 필요에 따라 다른 페이지로 이동하는 로직 추가
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          minimumSize: const Size(0, 100),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: Colors.grey[300]!,
              width: 1.0,
            ),
          ),
        ),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              width: 30,
              height: 30,
            ),
            const SizedBox(height: 5),
            Text(
              text,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
