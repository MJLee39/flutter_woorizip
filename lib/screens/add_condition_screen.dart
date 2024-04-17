import 'package:flutter/material.dart';
import 'package:testapp/widgets/client/number_input_widget.dart';
import 'package:testapp/widgets/client/calendar_widget.dart';
import 'package:testapp/widgets/client/button_widget.dart';

class AddConditionScreen extends StatelessWidget {
  const AddConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('상세 조건 설정'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "가격대: ~",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(child: const NumberInputWidget()),
                // 숫자 입력 위젯은 화면 너비에 맞게 확장
                Expanded(
                  child: Text(
                    "만원까지",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 10),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300], // 얇은 회색 선 추가
            ),

            const SizedBox(height: 20),
            const Text('입주가능일'),
            const SizedBox(height: 20),
            const CalendarWidget(),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300], // 얇은 회색 선 추가
            ),
            const SizedBox(height: 20),
            const Text('원하는 옵션을 선택해주세요'),
            _buildButtonRows(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle confirmation button press
              },
              child: const Text('확인'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRows() {
    final List<Widget> buttonRows = [];

    for (int i = 0; i < 20; i += 2) {
      buttonRows.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: 120,
            child: ToggleButtons(
              isSelected: [false, false], // 초기 선택 상태 설정
              onPressed: (int index) {
                // 버튼을 눌렀을 때 해당 버튼의 선택 상태를 토글
                // 여기서는 각 버튼이 서로 독립적으로 선택될 수 있도록 하기 위해
                // 현재 버튼의 선택 상태를 반전시킴
                final List<bool> selected = [false, false];
                selected[index] = !selected[index];
                // TODO: 선택된 버튼에 대한 작업 수행
              },
              fillColor: Colors.grey[200], // 선택된 버튼의 배경색
              selectedColor: Colors.black, // 선택된 버튼의 텍스트 색상
              splashColor: Colors.transparent, // 터치 피드백 없애기
              borderRadius: BorderRadius.circular(10),
              children: [
                Text('${i + 1}'),
                Text('${i + 2}'),
              ], // 버튼 모서리 둥글게 처리
            ),
          ),
        ),
      );

      // 각 행과 행 사이에 간격을 두기 위한 SizedBox 추가
      buttonRows.add(SizedBox(height: 10));
    }

    return Column(children: buttonRows);
  }
}
