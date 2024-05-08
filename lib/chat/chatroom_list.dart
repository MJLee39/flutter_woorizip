import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:eventflux/eventflux.dart';
import 'package:testapp/account/account_controller.dart';
import 'package:testapp/controllers/chat_controller.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'chat.dart';

class ChatRoomListScreen extends StatefulWidget {
  const ChatRoomListScreen({super.key});

  @override
  _ChatRoomListScreenState createState() => _ChatRoomListScreenState();
}

class _ChatRoomListScreenState extends State<ChatRoomListScreen> {
  final List<ChatRoomResponseDTO> _chatRooms = [];

  final ChatController _chatController = ChatController();
  final AccountController _accountController = AccountController();

  @override
  void initState() {
    super.initState();
    _chatController.fetchChatRooms(_accountController.id)
        .then((value) => {
          setState(() {
            _chatRooms.addAll(value);
            // for (var chatRoom in chatRooms) {
            //   subscribeToChatRoom(chatRoom.id);
            // }
          })
        })
        .catchError((err) => print(err));
  }

  void _removeChatRoom(ChatRoomResponseDTO chatRoom) {
    setState(() {
      _chatRooms.removeWhere((room) => room.id == chatRoom.id);
    });
  }

  void subscribeToChatRoom(String chatRoomId) {
    EventFlux.instance.connect(
      EventFluxConnectionType.get,
      'http://15.164.244.88:8080/chat/connect/$chatRoomId',
      onSuccessCallback: (EventFluxResponse? response) {
        response!.stream?.listen((data) {
          if (data.event == 'chat') {
            var eventData = jsonDecode(data.data);
            var updatedChatRoomId = eventData['chatRoomId'];
            var message = eventData['message'] ?? "안녕하세요.";

            setState(() {
              final index = _chatRooms.indexWhere((room) => room.id == updatedChatRoomId);
              if (index != -1) {
                final updatedRoom = _chatRooms[index];
                updatedRoom.recentMessage = message.contains('%%room%%') ? '매물' : message;
                _chatRooms.removeAt(index);
                _chatRooms.insert(0, updatedRoom);
              }
            });
          }
        });
      },
      onError: (error) {
        print('Error subscribing to chat room $chatRoomId: ${error.message}');
      },
      autoReconnect: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    _accountController.id;

    return Scaffold(
      appBar: AppBarWidget(title: '메시지',),
      body: PageNormalPaddingWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: _chatRooms.length,
                separatorBuilder: (context, index) => const Divider(color: Colors.grey),
                itemBuilder: (context, index) {
                  final chatRoom = _chatRooms[index];
                  return _ChatRoomTile(
                    chatRoom: chatRoom,
                    accountController: _accountController,
                    chatController: _chatController,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Chat(
                            chatRoomId: chatRoom.id,
                            accountId: _accountController.id,
                            myNickname: _accountController.nickname,
                            otherNickname: chatRoom.nickname,
                          ),
                        ),
                      );
                    },
                    onDismissed: _removeChatRoom,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}

class _ChatRoomTile extends StatelessWidget {
  const _ChatRoomTile({
    required this.chatRoom,
    required this.accountController,
    required this.chatController,
    required this.onTap,
    required this.onDismissed,
  });

  final ChatRoomResponseDTO chatRoom;
  final AccountController accountController;
  final ChatController chatController;
  final VoidCallback onTap;
  final Function(ChatRoomResponseDTO) onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(chatRoom.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        chatController.exitChatRoom(chatRoom.id).then((exitMessage) {
          if (exitMessage == 'deleted') {
            onDismissed(chatRoom);
          }
        });
      },
      child: ListTile(
        title: Text(
          chatRoom.nickname,
          style: const TextStyle(color: Colors.black),
        ),
        subtitle: chatRoom.recentMessage == null
            ? const Text(
                '대화 내용이 없습니다.',
                style: TextStyle(color: Colors.grey),
              )
            : Text(
                chatRoom.recentMessage.contains('%%room%%') ? '매물' : chatRoom.recentMessage,
                style: const TextStyle(color: Colors.grey),
              ),
        leading: CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: Text(
            chatRoom.nickname[0],
            style: const TextStyle(color: Colors.black),
          ),
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.warning,
            color: Colors.red,
          ),
          onPressed: () {
            var targetId;
            final userId = accountController.id;
            if (chatRoom.clientId == userId) {
              targetId = chatRoom.agentId;
            } else {
              targetId = chatRoom.clientId;
            }
            final result = chatController.sendReport(accountController.id, targetId);
            print(result);
          },
        ),
        onTap: onTap,
      ),
    );
  }
}