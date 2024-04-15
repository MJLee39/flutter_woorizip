import 'package:flutter/material.dart';
import 'package:testapp/screens/UpdatePictureScreen.dart';

class ResultSummaryScreen extends StatelessWidget {
  final String selectedAddress;
  final String selectedDong;
  final String selectedFloor;
  final String selectedHo;

  ResultSummaryScreen({
    Key? key,
    required this.selectedAddress,
    required this.selectedDong,
    required this.selectedFloor,
    required this.selectedHo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("선택 확인"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("선택한 주소: $selectedAddress", style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            if (selectedDong != "")
            Text("선택한 동: $selectedDong", style: TextStyle(fontSize: 20)),
            if (selectedDong != "")
            SizedBox(height: 10),
            Text("선택한 층: $selectedFloor", style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text("선택한 호: $selectedHo", style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            ElevatedButton(
            onPressed: () {
              // Navigate to UpdatePictureScreen when the button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdatePictureScreen()),
              );
            },
            child: Text("확인"),
          ),
          ],
        ),
      ),
    );
  }
}
