import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/condition_controller.dart';

class DeleteConditionWidget extends StatelessWidget {
  final ConditionController conditionController;
  final Map<String, dynamic> condition;
  final VoidCallback onDeleteSuccess;

  DeleteConditionWidget({
    required this.conditionController,
    required this.condition,
    required this.onDeleteSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text('삭제할까요?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: () async {
            conditionController.id = condition['id'];
            try {
              await conditionController.deleteCondition();

              // 삭제 성공 후 onDeleteSuccess 콜백 함수 실행
              onDeleteSuccess();
            } catch (e) {
              Get.snackbar('Error', '다시 시도해보세요');
            } finally {
              Get.back();
            }
          },
          child: const Text('확인'),
        ),
      ],
    );
  }
}
