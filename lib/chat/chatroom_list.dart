import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:eventflux/eventflux.dart';
import 'package:testapp/controllers/chat_controller.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/text_header_widget.dart';
import 'chat.dart';

class ChatRoomListScreen extends StatefulWidget {
  final String accountId;

  const ChatRoomListScreen({super.key, required this.accountId});

  @override
  _ChatRoomListScreenState createState() => _ChatRoomListScreenState();
}

class _ChatRoomListScreenState extends State<ChatRoomListScreen> {
  late List<ChatRoomResponseDTO> chatRooms = [];

  final ChatController _chatController = ChatController();

  @override
  void initState() {
    super.initState();
    print(widget.accountId);
    _chatController.fetchChatRooms(widget.accountId)
        .then((value) => {
          setState(() {
            chatRooms = value;
            for (var chatRoom in chatRooms) {
              subscribeToChatRoom(chatRoom.id);
            }
          }
        )
    }).catchError((err) => print(err));
  }

  void subscribeToChatRoom(String chatRoomId) {
    EventFlux.instance.connect(
      EventFluxConnectionType.get,
      'https://chat.teamwaf.app/chat/connect/$chatRoomId',
      onSuccessCallback: (EventFluxResponse? response) {
        response!.stream?.listen((data) {
          if (data.event == 'chat') {
            var eventData = jsonDecode(data.data);
            var updatedChatRoomId = eventData['chatRoomId'];
            var message = eventData['message'] ?? "안녕하세요.";

            setState(() {
              final index = chatRooms.indexWhere((room) => room.id == updatedChatRoomId);
              if (index != -1) {
                final updatedRoom = chatRooms[index];
                updatedRoom.recentMessage = message;
                chatRooms.removeAt(index);
                chatRooms.insert(0, updatedRoom);
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
    return Scaffold(
      appBar: AppBarWidget(),
      body: PageNormalPaddingWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextHeaderWidget(text: "채팅방 목록",),
            Expanded(
              child: ListView.builder(
                itemCount: chatRooms.length,
                itemBuilder: (context, index) {
                  final chatRoom = chatRooms[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    color: Color(0xFF224488),
                    elevation: 4.0,
                    child: ListTile(
                      title: Text(
                        chatRoom.nickname,
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        chatRoom.recentMessage,
                        style: TextStyle(color: Colors.white),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text(
                          chatRoom.nickname[0],
                          style: TextStyle(color: Color(0xFF224488)),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.warning,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              var targetId;
                              final userId = widget.accountId;
                              if (chatRoom.clientId == userId) {
                                targetId = chatRoom.agentId;
                              } else {
                                targetId = chatRoom.clientId;
                              }
                              final result = _chatController.sendReport(widget.accountId, targetId);
                              print(result);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _chatController.exitChatRoom(chatRoom.id).then((exitMessage) {
                                if (exitMessage == 'deleted') {
                                  setState(() {
                                    chatRooms.removeWhere((element) => element.id == chatRoom.id);
                                  });
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Chat(
                              chatRoomId: chatRoom.id,
                              accountId: widget.accountId,
                              myNickname: "허위 매물 사기꾼",
                              otherNickname: chatRoom.nickname,
                            ),
                          ),
                        );
                      },
                    ),
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
