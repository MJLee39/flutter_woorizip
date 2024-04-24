import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/condition_read_all_controller.dart';

import 'package:testapp/controllers/chat_controller.dart';

import 'package:testapp/chat/chat.dart';

class ReadAllWidget extends StatelessWidget {
  ReadAllWidget({super.key});

  final ConditionReadAllController controller =
      Get.find<ConditionReadAllController>();
  final ChatController _chatController = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        // 데이터 로딩 중일 때 로딩 스피너 표시
        return const Center(child: CircularProgressIndicator());
      } else if (controller.error.value.isNotEmpty) {
        // 데이터 로딩 실패 시 오류 메시지 표시
        return Center(
          child: Text('Error: ${controller.error.value}'),
        );
      } else {
        // 데이터를 가져왔을 때 목록 표시
        return Expanded(
          child: ListView.builder(
            itemCount: controller.jsonData.length,
            itemBuilder: (context, index) {
              final condition = controller.jsonData[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      // left: text
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('지역: ${condition['location']}'),
                            Text('건물유형: ${condition['buildingType']}'),
                            Text('희망금액: ${condition['fee']}'),
                            Text('입주가능일: ${condition['moveInDate']}'),
                            Text('희망옵션: ${condition['hashtag']}'),
                          ],
                        ),
                      ),
                      // right: buttons
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // chat
                            IconButton(
                              onPressed: () {
                                // chat events
                              },
                              icon: Icon(Icons.chat),
                            ),
                            // set condition
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
                              icon: Icon(Icons.settings),
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
