import 'dart:convert';
import 'package:flutter/gestures.dart'; // RichText 위젯 사용을 위해 추가
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class Chat extends StatefulWidget {
  final String chatRoomId;
  final String accountId;

  const Chat({Key? key, required this.chatRoomId, required this.accountId}) : super(key: key);

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  final String webSocketUrl = 'https://chat.teamwaf.app/stomp/chat';
  late StompClient _client;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<dynamic> messages = [];

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
    _fetchChatRoom();
  }

  void onConnectCallback(StompFrame connectFrame) {
    _client.subscribe(
      destination: '/exchange/chat.exchange/room.${widget.chatRoomId}',
      headers: {},
      callback: (frame) {
        setState(() {
          messages.insert(0, json.decode(frame.body!));
          _scrollController.jumpTo(_scrollController.position.minScrollExtent);
        });
      },
    );
  }

  Future<void> _fetchChatRoom() async {
    if (!mounted) return;

    final url = Uri.parse("https://chat.teamwaf.app/chat/room/resp?chatRoomId=${widget.chatRoomId}&accountId=${widget.accountId}");
    final response = await http.get(url);

    if (mounted) {
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        final chatMessages = jsonResponse['chatMessagesInRoom'];
        print(chatMessages);
        setState(() {
          messages.addAll(chatMessages);
        });
      } else {
        throw Exception("Failed to fetch chat room");
      }
    }
  }

  void _sendMessage() {
    final message = _controller.text;
    if (message.isNotEmpty) {
      _client.send(
        destination: '/pub/chat.message.${widget.chatRoomId}',
        body: json.encode({
          'chatRoomId': widget.chatRoomId,
          'message': message,
          'accountId': widget.accountId,
          'nickname': 'test',
        }),
      );
      _controller.clear();
    }
  }

  void _showItemList() async {
    final String url = 'http://10.0.2.2/zipListByAgent';
    final Map<String, dynamic> requestBody = {'agentId': '명진 부동산88'};

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final List<dynamic> items = json.decode(utf8.decode(response.bodyBytes));
      print("나왔다!!!!!!!!!!!!!!!!!!!!"+items.toString());
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
                  title: Text(item['direction']),
                  subtitle: Text(item['buildingType']),
                  onTap: () {
                    _handleMessageTap(item['id']);
                    Navigator.of(context).pop(); // BottomSheet 닫기
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  void _handleMessageTap(String? id) {
    if (id != null) {
      _controller.text = '%%room%%'+id+'%%room%%';
      _sendMessage(); // 메시지 전송 함수 호출
    }
  }

  Widget _buildMessageWidget(Map<String, dynamic> message) {
    final String text = message['message'] ?? "안녕하세요.";
    final bool isMyMessage = message['accountId'] == widget.accountId;
    final bool containsWoorizip = text.toLowerCase().contains('woorizip');

    if (containsWoorizip) {
      return GestureDetector(
        onTap: () {
          _handleWoorizipButtonTap();
        },
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: isMyMessage ? Color(0xFF224488) : Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: isMyMessage ? Color(0xFF224488) : Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }

  void _handleWoorizipButtonTap() {
    // 특정 작업 수행
    print('Woorizip 버튼이 클릭되었습니다.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: messages.length,
                controller: _scrollController,
                itemBuilder: (context, index) {
                  Map<String, dynamic> item = messages[index];
                  return _buildMessageWidget(item);
                },
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _sendMessage,
                  child: Text('Send'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _showItemList,
                  child: Text('Show Items'),
                ),
              ],
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

  Future<void> _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
