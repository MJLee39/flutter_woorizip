import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eventflux/eventflux.dart';
import 'package:testapp/controllers/chat_controller.dart';

import 'chat.dart';

class ChatRoomList extends StatelessWidget {
  final String accountId;

  const ChatRoomList({super.key, required this.accountId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Chat Room List'),
        ),
        body: ChatRoomListScreen(accountId: accountId),
      ),
    );
  }
}

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
    _chatController.fetchChatRooms(widget.accountId)
        .then((value) => {
          setState(() {
            chatRooms = value;
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

            print('제발제발제발 : ${data.data}');

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
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatRooms.length,
              itemBuilder: (context, index) {
                final chatRoom = chatRooms[index];
                // Inside the ListView.builder's itemBuilder method
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  color: Color(0xFF224488),
                  elevation: 4.0, // Add elevation for a raised effect
                  child: ListTile(
                    title: Text(chatRoom.nickname, style: TextStyle(color: Colors.white),),
                    subtitle: Text(
                      chatRoom.recentMessage,
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(chatRoom.nickname[0], style: TextStyle(color: Color(0xFF224488)),),
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
                            print('Report Button Pressed for Chat Room ID: ${chatRoom.id}');
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.exit_to_app,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _chatController.exitChatRoom(chatRoom.id);
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
    );
  }
}
