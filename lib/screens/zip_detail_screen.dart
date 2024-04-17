import 'package:flutter/material.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';

class DetailScreen extends StatelessWidget {
  final String itemID; // zipID를 저장하기 위한 필드

  DetailScreen({required this.itemID}); // 생성자


  final Map<String, dynamic> zipData = {
    "id": "1",
    "attachments": "af0a4ad6-c546-45c5-b527-32ac565b7f2d",
    "agentId": "명진 부동산44",
    "checkedAt": "2024-04-09T15:00:00",
    "estateId": "1",
    "direction": "남동향",
    "totalFloor": 3,
    "buildingFloor": 2,
    "buildingType": "아파트",
    "deposit": 100000,
    "fee": 45,
    "available": "2024-04-09T15:00:00",
    "hashtag": "#역세권",
    "m2": 33.0,
    "location": "서울시 마포구 상암동",
    "showYes": "public",
    "note": "상세주소 11동",
    "room": 1,
    "toilet":1,
    "maintenanceFee": 1.0
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://test.teamwaf.app/attachment/'+zipData['attachments']), //배경 이미지 URL
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
                  child: Text( "확인 일자: "+
                      zipData["checkedAt"].toString().substring(0,10), // checkedAt 정보 표시
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
                          "월세 " + zipData["deposit"].toString() + " / " + zipData["fee"].toString(),
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0)
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                      children: [
                        Text("관리비 "+zipData["maintenanceFee"].toString()+"만원",
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
                          zipData["buildingFloor"].toString()+"층",
                          style: TextStyle(fontSize: 25.0)),
                      SizedBox(width: 10.0),
                      Text("/"),
                      SizedBox(width: 10.0),
                      Text(
                          zipData["totalFloor"].toString()+"층",
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
                          "방 "+zipData["room"].toString()+"개, 화장실 "+zipData["toilet"].toString()+"개",
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
                          zipData["available"].toString().substring(0, 10) + " 이후 입주 가능",
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
                    backgroundColor: Colors.blue, // 버튼의 배경색을 파란색으로 설정
                    textStyle: TextStyle(fontSize: 30), // 텍스트의 크기를 20으로 설정
                    minimumSize: Size(200, 60), // 버튼의 최소 크기를 지정 (가로: 200, 세로: 60)
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // 버튼의 모서리를 둥글게 설정
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
