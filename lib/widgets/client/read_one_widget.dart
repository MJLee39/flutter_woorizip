import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/condition_controller.dart';
import 'package:testapp/controllers/chat_controller.dart';
import 'package:testapp/chat/chat.dart';
import 'package:testapp/widgets/client/delete_condition_widget.dart';

class ReadOneWidget extends StatelessWidget {
  ReadOneWidget({super.key});

  final ConditionController conditionController =
      Get.find<ConditionController>();
  final ChatController _chatController = ChatController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (conditionController.isLoading.value) {
        print('** v1 - conditionController.isLoading.value');
        return const Center(child: CircularProgressIndicator());
      } else if (conditionController.error.value.isNotEmpty) {
        print('** v2 - conditionController.error.value.isNotEmpty');
        return Center(
          child: Text('Error: ${conditionController.error.value}'),
        );
      } else {
        print('** v3 - spread content');
        return Expanded(
          child: ListView.builder(
            itemCount: conditionController.jsonData.length,
            itemBuilder: (context, index) {
              final condition = conditionController.jsonData[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('지역: ${condition['location']}'),
                            Text('건물유형: ${condition['buildingType']}'),
                            Text('희망금액: ${condition['fee']}만원'),
                            Text('입주가능일: ${condition['moveInDate']}'),
                            Text('희망옵션: ${condition['hashtag']}'),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // 조건 수정
                            IconButton(
                              onPressed: () {
                                Get.toNamed('/setdetails', arguments: {
                                  'id': condition['id'],
                                  'accoountId': condition['accountId'],
                                  'location': condition['location'],
                                  'buildingType': condition['buildingType'],
                                  'fee': condition['fee'],
                                  'moveInDate': condition['moveInDate'],
                                  'hashtag': condition['hashtag'],
                                });
                              },
                              icon: const Icon(Icons.settings),
                            ),

                            // 조건 삭제
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return DeleteConditionWidget(
                                      conditionController: conditionController,
                                      condition: condition,
                                      onDeleteSuccess: () {
                                        // 조건 삭제 후 페이지 다시 로드
                                        conditionController
                                            .readAllCondition()
                                            .then((_) {
                                          // 페이지 리프레시
                                          // 필요한 경우 setState() 사용
                                          // setState(() {});
                                        });
                                      },
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.cancel),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }
    });
  }
}
