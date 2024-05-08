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
  late List<ChatRoomResponseDTO> chatRooms = [];

  final ChatController _chatController = ChatController();
  final AccountController _accountController = AccountController();

  @override
  void initState() {
    super.initState();
    _chatController.fetchChatRooms(_accountController.id)
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
      'http://15.164.244.88:8080/chat/connect/$chatRoomId',
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
    _accountController.id;

    return Scaffold(
      appBar: AppBarWidget(title: '메시지',),
      body: PageNormalPaddingWidget(
        child: SingleChildScrollView(
          child: DataTable(
            columns: [
              DataColumn(
                label: Text(
                  '닉네임',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              DataColumn(
                label: Text(
                  '최근 메시지',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              DataColumn(
                label: Text(
                  '옵션',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            rows: chatRooms.map((chatRoom) {
              return DataRow(
                cells: [
                  DataCell(
                    Text(
                      chatRoom.nickname,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  DataCell(
                    Text(
                      chatRoom.recentMessage,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  DataCell(
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.warning,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            var targetId;
                            final userId = _accountController.id;
                            if (chatRoom.clientId == userId) {
                              targetId = chatRoom.agentId;
                            } else {
                              targetId = chatRoom.clientId;
                            }
                            final result = _chatController.sendReport(_accountController.id, targetId);
                            print(result);
                          },
                        ),
                        IconButton(
                          icon: const Icon(
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
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
  
}
