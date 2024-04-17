import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testapp/widgets/bottom_navigation_widget.dart';

class DetailScreen extends StatefulWidget  {
  final String itemID; // zipID를 저장하기 위한 필드

  DetailScreen({required this.itemID}); // 생성자

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Map<String, dynamic> zipData = {};

  @override
  void initState() {
    super.initState();
    fetchData(); // 데이터를 가져오는 메서드 호출
  }

  void fetchData() async {
    final response = await http.get(
        Uri.parse('http://localhost/zipOne?zip_id=${widget.itemID}'));
        //Uri.parse('http://10.0.2.2/zipOne?zip_id=${widget.itemID}'));

    if (response.statusCode == 200) {
      // HTTP 요청이 성공하면 응답을 처리합니다.
      final Map<String, dynamic> responseData = json.decode(
          utf8.decode(response.bodyBytes));
      setState(() {
        // zipData를 업데이트하여 받은 데이터로 화면을 다시 그립니다.
        zipData = responseData;
      });
    } else {
      // HTTP 요청이 실패한 경우에 대한 처리를 여기에 추가할 수 있습니다.
    }
  }

  @override
  Widget build(BuildContext context) {
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
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://test.teamwaf.app/attachment/' +
                                zipData['attachments']), //배경 이미지 URL
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                  ),
                ],
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
                          size: 40.0,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          zipData["location"],
                          style: TextStyle(color: Colors.black, fontSize: 24.0),
                        ),
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
                    Divider(color: Colors.blueAccent),
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
                      // 버튼이 클릭되었을 때 수행할 동작
                      // 예: 문의하기 기능 실행

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
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