import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/chat_controller.dart';

class ChatRoomListScreen extends GetView<ChatController> {
  const ChatRoomListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Obx(
                  () => ListView.builder(
                itemCount: controller.chatRooms.length,
                itemBuilder: (context, index) {
                  final chatRoom = controller.chatRooms[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    color: const Color(0xFF224488),
                    elevation: 4.0,
                    child: ListTile(
                      title: Text(
                        chatRoom['nickname'] ?? '',
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        chatRoom['recentMessage'] ?? '',
                        style: const TextStyle(color: Colors.white),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text(
                          (chatRoom['nickname'] ?? '')[0],
                          style: const TextStyle(color: Color(0xFF224488)),
                        ),
                      ),
                      onTap: () {
                        Get.toNamed('/chat/${chatRoom['id']}/qassadsadsa');
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}