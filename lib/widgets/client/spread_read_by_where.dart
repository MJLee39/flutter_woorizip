import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/condition_controller.dart';
import 'package:testapp/controllers/chat_controller.dart';
import 'package:testapp/chat/chat.dart';

class SpreadReadByWhereWidget extends StatelessWidget {
  SpreadReadByWhereWidget({super.key});

  final ConditionController conditionController = Get.find<ConditionController>();
  final ChatController _chatController = ChatController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (conditionController.isLoading.value) {
        print('** conditionController.isLoading.value');
        return const Center(child: CircularProgressIndicator());
      } else if (conditionController.error.value.isNotEmpty) {
        print('** conditionController.error.value.isNotEmpty');
        return Center(
          child: Text('Error: ${conditionController.error.value}'),
        );
      } else {
        print('** its OK. now in else');
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
                            IconButton(
                              onPressed: () {
                                final agentId = "qassadsadsa";
                                const clientId = "qweqwewqeewq";
                                var otherNickname;
                                _chatController.getNicknameBy(clientId).then(
                                        (value) => otherNickname = value
                                );

                                _chatController
                                    .createChatRoom(clientId, agentId)
                                    .then((chatRoomInfo) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Chat(
                                        chatRoomId: chatRoomInfo['id'],
                                        accountId: clientId,
                                        myNickname: "허위 매물 사기꾼",
                                        otherNickname: otherNickname,
                                      ),
                                    ),
                                  );
                                });
                              },
                              icon: const Icon(Icons.chat),
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
