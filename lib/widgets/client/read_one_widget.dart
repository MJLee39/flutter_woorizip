import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/condition_controller.dart';
import 'package:testapp/controllers/chat_controller.dart';
import 'package:testapp/chat/chat.dart';

class ReadOneWidget extends StatelessWidget {
  ReadOneWidget({super.key});

  final ConditionController conditionController = Get.find<ConditionController>();
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
        // conditionController.readAllCondition();

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
                            // chat
                            IconButton(
                              onPressed: () {
                                final agentId = "qassadsadsa";
                                const clientId = "qweqwewqeewq";

                                _chatController.createChatRoom(clientId, agentId).then((chatRoomInfo) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Chat(
                                        chatRoomId: chatRoomInfo['id'],
                                        accountId: clientId,
                                      ),
                                    ),
                                  );
                                });
                              },
                              icon: Icon(Icons.chat),
                            ),

                            // update condition
                            IconButton(
                              onPressed: () {
                                Get.toNamed('/updatecondition',
                                    arguments: {
                                      'id':condition['id'],
                                      'accoountId':condition['acoundId'],
                                      'location':condition['location'],
                                      'buildingType':condition['buildingType'],
                                      'fee':condition['fee'],
                                      'moveInDate':condition['moveInDate'],
                                      'hashtag':condition['hashtag'],
                                    });
                              },
                              icon: const Icon(Icons.settings),
                            ),

                            // delete condition
                            IconButton(
                              onPressed: () {
                                Get.dialog(
                                  AlertDialog(
                                    content: const Text('삭제할까요?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: const Text('취소'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          conditionController.id = condition['id'];
                                          // conditionController.accountId = condition['accountId'];
                                          conditionController.deleteCondition();
                                          Get.back(); // 작업 후 다이얼로그 닫기
                                          conditionController.readAllCondition(); // 페이지 새로고침
                                        },
                                        child: const Text('확인'),
                                      ),


                                    ],
                                  ),
                                  barrierDismissible: true,
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