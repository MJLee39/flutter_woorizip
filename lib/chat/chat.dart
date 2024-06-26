import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testapp/account/account_controller.dart';
import 'package:testapp/controllers/chat_controller.dart';
import 'package:testapp/screens/test/room_detail_screen.dart';
import 'package:testapp/widgets/app_bar_widget.dart';
import 'package:testapp/widgets/page_normal_padding_widget.dart';
import 'package:testapp/widgets/text_header_widget.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:get/get.dart';

import '../utils/api_config.dart';

class Chat extends StatefulWidget {
  final String chatRoomId;
  final String accountId;
  final String myNickname;
  final String otherNickname;

  const Chat({
    Key? key,
    required this.chatRoomId,
    required this.accountId,
    required this.myNickname,
    required this.otherNickname,
  }) : super(key: key);

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  final String webSocketUrl = 'http://15.164.244.88:8080/stomp/chat';
  late StompClient _client;
  final ChatController _chatController = ChatController();
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final AccountController _accountController = AccountController();

  List<dynamic> messages = [];

  String imageURL = '';

  @override
  void initState() {
    super.initState();
    _client = StompClient(
      config: StompConfig.sockJS(
        url: webSocketUrl,
        onConnect: onConnectCallback,
      ),
    );
    _client.activate();
    _chatController
        .fetchChatRoom(widget.chatRoomId)
        .then((value) => {
              setState(() {
                if (value != null) {
                  messages.addAll(value);
                }
              })
            });
  }

  void onConnectCallback(StompFrame connectFrame) {
    print(widget.chatRoomId);

    _client.subscribe(
      destination: '/exchange/${widget.chatRoomId}',
      headers: {},
      callback: (frame) {
        setState(() {
          messages.add(json.decode(frame.body!));
          if (_scrollController.hasClients &&
              _scrollController.position.minScrollExtent != null) {
            _scrollController.jumpTo(_scrollController.position.minScrollExtent);
          }
        });
      },
    );
  }

  void _sendMessage() {
    final message = _controller.text;
    if (message.isNotEmpty) {
      _client.send(
        destination: '/pub/${widget.chatRoomId}',
        body: json.encode({
          'chatRoomId': widget.chatRoomId,
          'message': message,
          'accountId': widget.accountId,
          'nickname': widget.myNickname,
        }),
      );
      _controller.clear();
    }
  }

  void _showItemList() async {
    final response = await http.get(Uri.parse(
        'https://api.teamwaf.app/v1/zip/agent/' + _accountController.id));

    if (response.statusCode == 200) {
      final List<dynamic> items =
          json.decode(utf8.decode(response.bodyBytes))['Zips'];
      print("나왔다!!!!!!!!!!!!!!!!!!!!" + items.toString());
      _showItems(items);
    } else {
      throw Exception('Failed to load items');
    }
  }

  void _showItems(List<dynamic> items) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          child: SingleChildScrollView(
            child: Column(
              children: items.map((item) {
                return ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("보증금/월세: " +
                                item['deposit'].toString() +
                                "/" +
                                item['fee'].toString()),
                            Text(item['location'] + ", " + item['buildingType']),
                            Text(item['note']),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 100,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                              '${ApiConfig.attachmentApiEndpointUri}/' +
                                  (item['attachments']?.split(',')[0] ?? ''),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    _handleMessageTap(
                        item['id'], item['attachments']?.split(',')[0] ?? '');
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  void _handleMessageTap(String? id, String? attachments) {
    if (id != null) {
      _controller.text = '%%room%%' + id + '%%room%%';
      _controller.text += '%%image%%' + attachments!;
      _sendMessage();
    }
  }

  String checkNickname(String accountId) {
    if (accountId == widget.accountId) {
      return widget.myNickname;
    }
    return widget.otherNickname;
  }

  Widget _buildMessageWidget(Map<String, dynamic> message) {
    final String originalText = message['message'] ?? "안녕하세요.";
    final String id = (originalText.split('%%room%%%%image%%').first)
        .replaceAll('%%room%%', '');
    final String img = originalText.split('%%room%%%%image%%').last;
    final String nickname = checkNickname(message['accountId']);
    final bool isMyMessage = message['accountId'] == widget.accountId;
    final bool containsWoorizip = originalText.toLowerCase().contains('%%room%%');

    return Column(
      crossAxisAlignment:
          isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (!isMyMessage)
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xFF224488),
                    width: 1,
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    nickname[0],
                    style: TextStyle(color: Color(0xFF224488)),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text(
                nickname,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        Padding(
          padding: EdgeInsets.only(left: 30),
          child: GestureDetector(
            onTap: containsWoorizip
                ? () {
                    Get.to(RoomDetailScreen(itemID: id),
                        transition: Transition.noTransition);
                  }
                : null,
            child: CustomPaint(
              painter: ChatBubblePainter(
                isMyMessage: isMyMessage,
                color: isMyMessage ? Color(0xFF224488) : Colors.grey,
              ),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    containsWoorizip
                        ? Text(
                            '매물 보러가기',
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                          )
                        : SizedBox.shrink(),
                    containsWoorizip && img.isNotEmpty
                        ? Image.network(
                            '${ApiConfig.attachmentApiEndpointUri}/' + img,
                            fit: BoxFit.cover,
                            width: 200,
                            height: 200,
                          )
                        : SizedBox.shrink(),
                    containsWoorizip
                        ? SizedBox.shrink()
                        : Text(
                            originalText,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarWidget(
        title: widget.otherNickname,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.warning_amber, color: Colors.red, size: 30),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
      body: PageNormalPaddingWidget(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                reverse: true,
                itemCount: messages.length,
                controller: _scrollController,
                separatorBuilder: (context, index) =>
                    SizedBox(height: 15), // Here is the correction
                itemBuilder: (context, index) {
                  Map<String, dynamic> item = messages[index];
                  return _buildMessageWidget(
                    messages[messages.length - 1 - index],
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _showItemList,
                    icon: Icon(Icons.add),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: '메시지 입력...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _sendMessage,
                    icon: Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _client.deactivate();
    _controller.dispose();
    super.dispose();
  }
}

class ChatBubblePainter extends CustomPainter {
  final bool isMyMessage;
  final Color color;
  final double minBubbleLength;

  ChatBubblePainter(
      {required this.isMyMessage, required this.color, this.minBubbleLength = 50.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    if (isMyMessage) {
      path.moveTo(15, 0);
      path.quadraticBezierTo(0, 0, 0, 15);
      path.lineTo(0, size.height - 15);
      path.quadraticBezierTo(0, size.height, 20, size.height);
      path.lineTo(40, size.height);
      if (size.width >= minBubbleLength) {
        path.quadraticBezierTo(60, size.height + 10, 50, size.height);
      }
      path.lineTo(size.width - 10, size.height);
      path.quadraticBezierTo(size.width, size.height, size.width, size.height - 15);
      path.lineTo(size.width, 15);
      path.quadraticBezierTo(size.width, 0, size.width - 20, 0);
    } else {
      path.moveTo(size.width - 15, 0);
      path.quadraticBezierTo(size.width, 0, size.width, 15);
      path.lineTo(size.width, size.height - 15);
      path.quadraticBezierTo(size.width, size.height, size.width - 20, size.height);
      path.lineTo(size.width - 40, size.height);
      if (size.width >= minBubbleLength) {
        path.quadraticBezierTo(size.width - 60, size.height + 10, size.width - 50, size.height);
      }
      path.lineTo(10, size.height);
      path.quadraticBezierTo(0, size.height, 0, size.height - 15);
      path.lineTo(0, 15);
      path.quadraticBezierTo(0, 0, 10, 0);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}