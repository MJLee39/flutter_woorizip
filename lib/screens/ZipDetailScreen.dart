import 'package:flutter/material.dart';
import 'package:testapp/widgets/BottomNavigationWidget.dart';

class DetailScreen extends StatelessWidget {
  final String itemID; // zipID를 저장하기 위한 필드

  DetailScreen({required this.itemID}); // 생성자

  final Map<String, dynamic> zipData = {
    "id": "1",
    "attachments": "data44",
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
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("/images/room2.jpg"), // 변경된 배경 이미지 URL
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
            Padding(
              padding: const EdgeInsets.all(40.0),
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
                    children: <Widget>[
                      Text(
                          "월세 " + zipData["deposit"].toString(),
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0)),
                      SizedBox(width: 10.0),
                      Text("/",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0)),
                      SizedBox(width: 10.0),
                      Text(
                        zipData["fee"].toString(),
                        style: TextStyle(fontSize: 40.0)),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Divider(color: Colors.green),
                  SizedBox(height: 10.0),
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
                  ListTile(
                    title: Text("Area"),
                    subtitle: Text(zipData["m2"].toString() + " m²"),
                  ),
                  ListTile(
                    title: Text("Direction"),
                    subtitle: Text(zipData["direction"]),
                  ),
                  ListTile(
                    title: Text("Available Date"),
                    subtitle: Text(zipData["available"]),
                  ),
                  ListTile(
                    title: Text("Hashtag"),
                    subtitle: Text(zipData["hashtag"]),
                  ),
                  ListTile(
                    title: Text("Note"),
                    subtitle: Text(zipData["note"]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }
}
