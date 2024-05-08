import 'package:flutter/material.dart';
import 'package:testapp/controllers/chat_controller.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/controllers/zip_detail_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:testapp/utils/app_colors.dart';
import '../chat/chat.dart';

class DetailScreen extends StatefulWidget  {
  final String itemID; // zipID를 저장하기 위한 필드

  DetailScreen({required this.itemID}); // 생성자

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Map<String, dynamic> zipData = {};
  final ZipDataController _zipDataController = ZipDataController();
  final ChatController _chatController = ChatController();

  @override
  void initState() {
    super.initState();
    fetchData(); // 데이터를 가져오는 메서드 호출
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
      // 데이터 로드 실패 시 처리
    }
  }

  @override
  Widget build(BuildContext context) {

    final List<String> imageList = [
      'assets/images/room1.jpg',
      'assets/images/room2.jpg',
      // 여기에 추가 이미지 경로 추가 가능
    ];

    if (zipData.isEmpty) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(), // 데이터를 기다리는 동안 로딩 표시
        ),
      );
    } else {
      // zipData가 초기화된 경우에는 화면을 그립니다.
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Stack(
              //   children: <Widget>[
              //     Container(
              //       height: MediaQuery
              //           .of(context)
              //           .size
              //           .height * 0.5,
              //       decoration: BoxDecoration(
              //         image: DecorationImage(
              //           image: NetworkImage(
              //               'https://test.teamwaf.app/attachment/' +
              //                   zipData['attachments']), //배경 이미지 URL
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //     ),
              //     Positioned(
              //       left: 0,
              //       right: 0,
              //       bottom: 0,
              //       child: Padding(
              //         padding: EdgeInsets.all(40.0),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  enableInfiniteScroll: true,
                  enlargeCenterPage: true,
                ),
                items: imageList.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          image: DecorationImage(
                            image: AssetImage(imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.yellow, // 노란색 배경색상
                        borderRadius: BorderRadius.circular(10.0), // 모서리 둥글게
                      ),
                      child: Text("확인 일자: " +
                          zipData["checkedAt"].toString().substring(0, 10),
                        // checkedAt 정보 표시
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ]
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.directions_car,
                          color: Colors.black,
                          size: 24.0,
                        ),
                        SizedBox(width: 10.0),
                        Wrap(
                          children: <Widget>[
                            Text(
                              zipData["location"],
                              style: TextStyle(color: Colors.black, fontSize: 20.0),
                            ),
                          ],
                        )
                      ],
                    ),

                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Text(
                            "월세 " + zipData["deposit"].toString() + " / " +
                                zipData["fee"].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 40.0)
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Text(
                          "관리비 " + zipData["maintenanceFee"].toString() + "만원",
                          style: TextStyle(fontSize: 20.0),)
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Divider(color: AppColors.mainColor),
                    SizedBox(height: 20.0),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.account_balance,
                          color: Colors.black,
                          size: 25.0,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                            zipData["buildingFloor"].toString() + "층",
                            style: TextStyle(fontSize: 25.0)),
                        SizedBox(width: 10.0),
                        Text("/"),
                        SizedBox(width: 10.0),
                        Text(
                            zipData["totalFloor"].toString() + "층",
                            style: TextStyle(fontSize: 25.0))
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.crop_free,
                          color: Colors.black,
                          size: 25.0,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                            zipData["m2"].toString() + " m²",
                            style: TextStyle(fontSize: 25.0)),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.arrow_circle_up,
                          color: Colors.black,
                          size: 25.0,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                            zipData["direction"].toString(),
                            style: TextStyle(fontSize: 25.0)),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.dashboard,
                          color: Colors.black,
                          size: 25.0,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                            "방 " + zipData["room"].toString() + "개, 화장실 " +
                                zipData["toilet"].toString() + "개",
                            style: TextStyle(fontSize: 25.0)),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.date_range,
                          color: Colors.black,
                          size: 25.0,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                            zipData["available"].toString().substring(0, 10) +
                                " 이후 입주 가능",
                            style: TextStyle(fontSize: 25.0)),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.add_home_work_outlined,
                          color: Colors.black,
                          size: 25.0,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                            zipData["hashtag"].toString(),
                            style: TextStyle(fontSize: 25.0)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        final agentId = "qassadsadsa";
                        const clientId = "qweqwewqeewq";
                        var otherNickname;
                        _chatController.getNicknameBy(agentId).then(
                                (value) => otherNickname = value
                        );

                        _chatController.createChatRoom(clientId, agentId).then((chatRoomInfo) {
                          Navigator.push(
                            context, MaterialPageRoute(
                              builder: (context) => Chat(
                                chatRoomId: chatRoomInfo['id'],
                                accountId: clientId,
                                myNickname: "허위 매물 사기꾼",
                                otherNickname: otherNickname,
                              ),
                            ),
                          );
                        });
                      },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainColor1,
                      // 버튼의 배경색을 파란색으로 설정
                      textStyle: TextStyle(fontSize: 30),
                      // 텍스트의 크기를 20으로 설정
                      minimumSize: Size(200, 60),
                      // 버튼의 최소 크기를 지정 (가로: 200, 세로: 60)
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10), // 버튼의 모서리를 둥글게 설정
                      ),
                    ),
                    child: Text('문의하기', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationWidget(),
      );
    }
  }
}