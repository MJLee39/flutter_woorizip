import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/utils/app_colors.dart';

class RoundInputWidgetController extends GetxController {
  var isFocused = false.obs;
}

class RoundInputWidget extends StatelessWidget {
  final RoundInputWidgetController controller = Get.put(RoundInputWidgetController());
  final String hint;
  final TextEditingController textController;

  RoundInputWidget({super.key, required this.hint, required this.textController});

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
        controller: textController,
        onTap: () {
          controller.isFocused.value = true;
        },
        onSubmitted: (_) {
          controller.isFocused.value = false;
        },
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15.0),
        ),
      ),
    ));
  }
}