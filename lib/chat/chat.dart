import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testapp/controllers/chat_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:get/get.dart';
import 'package:testapp/screens/zip_detail_screen.dart';

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
  final ChatController _chatController = ChatController();
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
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
    _chatController.fetchChatRoom(widget.chatRoomId, widget.accountId).then((value) => {
      setState(() {
        messages.addAll(value);
      })
    });
  }

  void onConnectCallback(StompFrame connectFrame) {
    _client.subscribe(
      destination: '/exchange/chat.exchange/room.${widget.chatRoomId}',
      headers: {},
      callback: (frame) {
        setState(() {
          messages.add(json.decode(frame.body!));
          if (_scrollController.hasClients && _scrollController.position.minScrollExtent != null) { // ScrollController에 클라이언트가 있는지 확인
            _scrollController.jumpTo(_scrollController.position.minScrollExtent);
          }
        });
      },
    );
  }

  //텍스트 보내기
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
    final String url = 'http://localhost/zipListByAgent';
    final Map<String, dynamic> requestBody = {'agentId': '명진 부동산1'};
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
                  title: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("보증금/월세: "+item['deposit'].toString()+"/"+item['fee'].toString()),
                            Text(item['location']+", "+item['buildingType']),
                            Text(item['note']),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      // Image.network(
                      //   'https://test.teamwaf.app/attachment/${item['attachments']}',
                      //   width: 100, // 이미지 너비 조정
                      //   height: 90, // 이미지 높이 조정
                      // ),
                      Image.asset(
                        'assets/images/room1.jpg',
                        width: 100,
                        height: 90,
                      ),
                    ],
                  ),
                  onTap: () {
                    _handleMessageTap(item['id'], item['attachments']);
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



  void _handleMessageTap(String? id, String? attachments) {
    if (id != null) {
      _controller.text = '%%room%%'+id+'%%room%%';
      //imageURL = '$attachments';
      _controller.text += '%%image%%'+'assets/images/room1.jpg';
      _sendMessage(); // 메시지 전송 함수 호출
    }
  }

  Widget _buildMessageWidget(Map<String, dynamic> message) {
    final String originalText = message['message'] ?? "안녕하세요.";
    final String id = (originalText.split('%%room%%%%image%%').first).replaceAll('%%room%%', '');
    final String img = originalText.split('%%room%%%%image%%').last;
    final String nickname = message['nickname'] ?? "익명"; // 닉네임
    final bool isMyMessage = message['accountId'] == widget.accountId;
    final bool containsWoorizip = originalText.toLowerCase().contains('%%room%%');

    return Column(
      crossAxisAlignment: isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          nickname, // 닉네임 표시
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: containsWoorizip
              ? () {
            Get.to(DetailScreen(itemID: id), transition: Transition.noTransition);
          }
              : null,
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: isMyMessage ? Color(0xFF224488) : Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
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
                    : SizedBox.shrink(), // 매물 보러가기 텍스트가 있는 경우에만 표시
                containsWoorizip && img.isNotEmpty
                    ? Image.asset(
                  img,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover, // 이미지를 화면에 맞게 조정
                )
                    : SizedBox.shrink(), // 이미지가 있는 경우에만 표시
                containsWoorizip ? SizedBox.shrink() : Text( // containsWoorizip가 false이면 전체 메시지를 보여줌
                  originalText,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
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
                  return _buildMessageWidget(messages[messages.length - 1 - index]);
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
                  child: const Icon(
                    Icons.send,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _showItemList,
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
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