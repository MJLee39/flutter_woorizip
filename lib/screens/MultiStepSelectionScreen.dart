import 'package:flutter/material.dart';
import 'package:testapp/controllers/ApiController.dart';
import 'package:testapp/screens/ResultSummaryScreen.dart';

class MultiStepSelectionScreen extends StatefulWidget {
  @override
  _MultiStepSelectionScreenState createState() => _MultiStepSelectionScreenState();
}

class _MultiStepSelectionScreenState extends State<MultiStepSelectionScreen> {
  final ApiController apiController = ApiController();
  late String selectedDong;
  late String selectedFloor;
  late String selectedHo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi-Step Selection'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 동 선택
          ElevatedButton(
            onPressed: () async {
              List<dynamic> addressList = await apiController.fetchDataFromApi('searchKeyword');
              setState(() {
                // 여기서 동 선택 로직을 구현하고 selectedDong 변수에 선택한 동을 저장합니다.
                // 예시로 '동 선택' 버튼을 누를 때 첫 번째 주소의 동을 선택한 것으로 설정합니다.
                selectedDong = addressList.isNotEmpty ? addressList.first['dongNm'] : '없음';
              });
            },
            child: Text('동 선택'),
          ),
          SizedBox(height: 20),
          // 층 선택
          ElevatedButton(
            onPressed: () async {
              // 여기서 층 선택 로직을 구현하고 selectedFloor 변수에 선택한 층을 저장합니다.
              // 예시로 '층 선택' 버튼을 누를 때 1층을 선택한 것으로 설정합니다.
              setState(() {
                selectedFloor = '1층';
              });
            },
            child: Text('층 선택'),
          ),
          SizedBox(height: 20),
          // 호 선택
          ElevatedButton(
            onPressed: () async {
              // 여기서 호 선택 로직을 구현하고 selectedHo 변수에 선택한 호를 저장합니다.
              // 예시로 '호 선택' 버튼을 누를 때 101호를 선택한 것으로 설정합니다.
              setState(() {
                selectedHo = '101호';
              });
            },
            child: Text('호 선택'),
          ),
          SizedBox(height: 20),
          // 결과 요약
          ElevatedButton(
            onPressed: () {
              // 여기서는 선택된 동, 층, 호를 가지고 결과 요약을 표시하는 화면으로 이동합니다.
              // 이동할 때 선택된 정보를 인자로 넘겨줄 수 있습니다.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultSummaryScreen(
                    selectedDong: selectedDong,
                    selectedFloor: selectedFloor,
                    selectedHo: selectedHo, selectedAddress: '',
                  ),
                ),
              );
            },
            child: Text('결과 요약'),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MultiStepSelectionScreen(),
  ));
}
