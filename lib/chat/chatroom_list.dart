import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eventflux/eventflux.dart';

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

  @override
  void initState() {
    super.initState();
    _fetchChatRooms();
  }

  Future<void> _fetchChatRooms() async {
    final url = Uri.parse("http://10.0.2.2:8818/chat/${widget.accountId}/room");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        chatRooms = jsonList.map((json) => ChatRoomResponseDTO.fromJson(json)).toList();
      });

      for (final chatRoom in chatRooms) {
        subscribeToChatRoom(chatRoom.id);
      }
    } else {
      throw Exception("Failed to fetch chat rooms");
    }
  }

  void subscribeToChatRoom(String chatRoomId) {
    EventFlux.instance.connect(
      EventFluxConnectionType.get,
      'http://10.0.2.2:8818/chat/connect/$chatRoomId',
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

class ChatRoomResponseDTO {
  final String id;
  final List<String> participantIds;
  final String nickname;
  final String clientId;
  final String brokerId;
  String recentMessage;

  ChatRoomResponseDTO({
    required this.id,
    required this.participantIds,
    required this.nickname,
    required this.clientId,
    required this.brokerId,
    required this.recentMessage,
  });

  factory ChatRoomResponseDTO.fromJson(Map<String, dynamic> json) {
    return ChatRoomResponseDTO(
      id: json['id'],
      participantIds: List<String>.from(json['participantIds']),
      nickname: json['nickname'],
      clientId: json['clientId'],
      brokerId: json['brokerId'],
      recentMessage: json['recentMessage'] ?? "",
    );
  }
}