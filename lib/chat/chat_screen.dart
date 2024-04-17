import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class ChatController extends GetxController {
  late final String accountId;
  late final String chatRoomId;
  late final StompClient _client;
  late final TextEditingController _controller;
  late final ScrollController _scrollController;
  late final RxList<dynamic> messages;

  @override
  void onInit() {
    super.onInit();
    accountId = Get.arguments['accountId'];
    chatRoomId = Get.arguments['chatRoomId'];
    print(accountId);
    print(chatRoomId);
    _controller = TextEditingController();
    _scrollController = ScrollController();
    messages = <dynamic>[].obs;
    _client = StompClient(
      config: StompConfig(
        url: 'ws://localhost:4888/ws',
        onConnect: _onConnectCallback,
      ),
    );
    _client.activate();
    _fetchChatRoom();
  }

  void _onConnectCallback(StompFrame connectFrame) {
    _client.subscribe(
      destination: '/exchange/chat.exchange/room.$chatRoomId',
      headers: {},
      callback: (frame) {
        final message = jsonDecode(frame.body!);
        messages.insert(0, message);
        _scrollController.jumpTo(_scrollController.position.minScrollExtent);
      },
    );
  }


  Future<void> _fetchChatRoom() async {
    final url = Uri.parse('http://localhost:4888/chat/room/resp?chatRoomId=$chatRoomId&accountId=$accountId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      final chatMessages = jsonResponse['chatMessagesInRoom'];
      messages.addAll(chatMessages);
    } else {
      throw Exception('Failed to fetch chat room');
    }
  }

  void sendMessage() {
    final message = _controller.text;
    if (message.isNotEmpty) {
      _client.send(
        destination: '/pub/chat.message.$chatRoomId',
        body: json.encode({
          'chatRoomId': chatRoomId,
          'message': message,
          'accountId': accountId,
          'nickname': 'test',
        }),
      );
      _controller.clear();
    }
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void onClose() {
    _scrollController.dispose();
    _client.deactivate();
    _controller.dispose();
    super.onClose();
  }
}

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Obx(
                    () => ListView.builder(
                  reverse: true,
                  itemCount: controller.messages.length,
                  controller: controller._scrollController,
                  itemBuilder: (context, index) {
                    final item = controller.messages[index];
                    final isMyMessage = item['accountId'] == controller.accountId;
                    return Column(
                      crossAxisAlignment: isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['nickname'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        Align(
                          alignment: isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              controller.launchURL(item['message']);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: isMyMessage ? const Color(0xFF224488) : Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                item['message'],
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller._controller,
                    decoration: const InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: controller.sendMessage,
                  child: Text('Send'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
