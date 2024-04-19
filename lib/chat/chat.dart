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
  final String webSocketUrl = 'http://10.0.2.2:8818/stomp/chat';
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

    final url = Uri.parse("http://10.0.2.2:8818/chat/room/resp?chatRoomId=${widget.chatRoomId}&accountId=${widget.accountId}");
    final response = await http.get(url);

    if (mounted) {
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        final chatMessages = jsonResponse['chatMessagesInRoom'];
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

  Widget _buildMessageText(String text) { // RichText 위젯 생성을 위한 함수 추가
    List<InlineSpan> spans = [];

    RegExp linkRegExp = RegExp(
      r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+',
      caseSensitive: false,
    );

    Iterable<Match> matches = linkRegExp.allMatches(text);
    int lastMatchEnd = 0;

    for (Match match in matches) {
      if (match.start > lastMatchEnd) {
        spans.add(
          TextSpan(
            text: text.substring(lastMatchEnd, match.start),
          ),
        );
      }
      spans.add(
        TextSpan(
          text: match.group(0),
          style: TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              _launchURL(match.group(0)!);
            },
        ),
      );
      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(lastMatchEnd),
        ),
      );
    }

    return RichText(
      text: TextSpan(
        children: spans,
      ),
    );
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
                  title: Text(item['title']),
                  subtitle: Text(item['description']),
                  onTap: () {
                    _handleMessageTap(item['id']);
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
    String url = 'http://example.com/item?id=$id'; // Construct URL based on the ID
    _controller.text = url;
  }

  void _showItemList() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8818/chat/${widget.accountId}/room'));
    if (response.statusCode == 200) {
      final List<dynamic> items = json.decode(response.body);
      _showItems(items);
    } else {
      throw Exception('Failed to load items');
    }
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
                  bool isMyMessage = item['accountId'] == widget.accountId;
                  return Column(
                    crossAxisAlignment: isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['nickname'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      Align(
                        alignment: isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            _launchURL(item['message'] ?? "안녕하세요.");
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: isMyMessage ? Color(0xFF224488) : Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: _buildMessageText(item['message'] ?? "안녕하세요."), // 메시지 텍스트 위젯 대체
                          ),
                        ),
                      ),
                    ],
                  );
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
