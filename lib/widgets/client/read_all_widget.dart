import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/condition_read_all_controller.dart';

class ReadAllWidget extends StatelessWidget {
  ReadAllWidget({super.key});

  final ConditionReadAllController controller =
      Get.find<ConditionReadAllController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        // 데이터 로딩 중일 때, 로딩 스피너 표시
        return const Center(child: CircularProgressIndicator());
      } else if (controller.error.value.isNotEmpty) {
        // 데이터 로딩 실패 시, 오류 메시지 표시
        return Center(
          child: Text('Error: ${controller.error.value}'),
        );
      } else {
        // 데이터를 가져왔을 때, 목록 표시
        return ListView.builder(
          itemCount: controller.jsonData.length,
          itemBuilder: (context, index) {
            final condition = controller.jsonData[index];
            return Card(
              child: ListTile(
                title: Text('Location: ${condition['location']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Building Type: ${condition['buildingType']}'),
                    Text('Fee: ${condition['fee']}'),
                    Text('Move-In Date: ${condition['moveInDate']}'),
                    Text('Hashtag: ${condition['hashtag']}'),
                  ],
                ),
              ),
            );
          },
        );
      }
    });
  }
}
