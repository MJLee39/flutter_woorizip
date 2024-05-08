import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/utils/app_colors.dart';

class RoundedInputBoxController extends GetxController {
  var isFocused = false.obs;
}

class RoundedInputBox extends StatelessWidget {
  final RoundedInputBoxController controller = Get.put(RoundedInputBoxController());
  final String hint;

  RoundedInputBox({required this.hint});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: controller.isFocused.value ? AppColors.mainColorTest : Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: TextField(
        onTap: () {
          controller.isFocused.value = true;
        },
        onSubmitted: (_) {
          controller.isFocused.value = false;
        },
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15.0),
        ),
      ),
    ));
  }
}