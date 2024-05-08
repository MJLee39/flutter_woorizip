import 'package:flutter/material.dart';
import 'package:testapp/account/account_controller.dart';
import 'package:testapp/controllers/chat_controller.dart';
import 'package:testapp/utils/api_config.dart';
import 'package:testapp/widgets/bottom_navbar_button.dart';
import 'package:testapp/controllers/zip_detail_controller.dart';
import 'package:get/get.dart';

class RoomDetailScreen extends StatefulWidget {
  final String itemID;

  RoomDetailScreen({super.key, required this.itemID});

  @override
  _RoomDetailScreenState createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  int _currentImageIndex = 0;
  late Map<String, dynamic> zipData = {};
  final ZipDataController _zipDataController = ZipDataController();
  final ChatController _chatController = Get.put(ChatController());
  final AccountController _accountController = Get.put(AccountController());

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      final Map<String, dynamic> result =
          await _zipDataController.fetchZipData(widget.itemID);
      setState(() {
        zipData = result;
      });
    } catch (error) {
      print('Error: $error');
    }
  }

  List<String> _images = [];

  @override
  Widget build(BuildContext context) {
    if (zipData.isEmpty) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      _images = zipData['attachments'].split(',');

      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white60,
          actions: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.favorite_border, color: Colors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.favorite, color: Colors.red),
                  onPressed: () {},
                ),
              ],
            )
          ],
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 16 / 13,
                child: Stack(
                  children: [
                    PageView.builder(
                      itemCount: _images.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentImageIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Image.network(
                          '${ApiConfig.attachmentApiEndpointUri}/${_images[index].trim()}',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    Positioned(
                      right: 16,
                      bottom: 16,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${_currentImageIndex + 1} / ${_images.length}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        zipData["checkedAt"].toString().substring(0, 10) + ' 확인됨',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      zipData["location"],
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '월세 ${zipData["deposit"]}/${zipData["fee"]}',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('관리비 ${zipData["maintenanceFee"]}만원'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: const Divider(
                          height: 24, thickness: 0.5, color: Colors.grey),
                    ),
                    Row(
                      children: [
                        Icon(Icons.straighten, color: Colors.grey[600]),
                        SizedBox(width: 4),
                        Text(
                          '전용 ${zipData["m2"]}㎡',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.navigation, color: Colors.grey[600]),
                        SizedBox(width: 4),
                        Text(
                          '${zipData["direction"].toString()}향',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.stairs, color: Colors.grey[600]),
                        SizedBox(width: 4),
                        Text(
                          '${zipData["buildingFloor"].toString()} / ${zipData["totalFloor"].toString()} 층',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.house, color: Colors.black),
                        SizedBox(width: 4),
                        Text(
                          '${zipData["buildingType"]}(방 ${zipData["room"]}개, 욕실 ${zipData["toilet"]}개)',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.tag, color: Colors.grey[600]),
                        SizedBox(width: 4),
                        Text(
                          zipData["hashtag"],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.event_available, color: Colors.grey[600]),
                        SizedBox(width: 4),
                        Text(
                          zipData["available"].toString().substring(0, 10) +
                              ' 이후 입주 가능',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavbarButton(
            label: '문의하기',
            onTap: () async {
              final agentId = zipData['agentId'];
              var clientId = _accountController.id;
              var otherNickname = await _chatController.getNicknameBy(agentId);

              var chatRoomInfo =
                  await _chatController.createChatRoom(clientId, agentId);
              Get.toNamed('/chat/${chatRoomInfo['id']}',
                  arguments: {
                    'accountId': clientId,
                    'otherNickname': otherNickname
                  });
            }),
      );
    }
  }
}