import 'package:flutter/material.dart';

class SetBuildingtypeButtons extends StatefulWidget {
  const SetBuildingtypeButtons({super.key});

  @override
  _FourButtonsContainerState createState() => _FourButtonsContainerState();
}

class _FourButtonsContainerState extends State<SetBuildingtypeButtons> {
  // 선택된 버튼을 나타내는 리스트
  List<bool> _selections = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ToggleButtons(
          isSelected: _selections,
          onPressed: (int index) {
            setState(() {
              for (int i = 0; i < _selections.length; i++) {
                _selections[i] = i == index;
              }
            });
          },
          selectedColor: Colors.white,
          fillColor: Colors.indigo,
          children: const [
            SizedBox(
              width: 100,
              child: Text('아파트'),
            ),
            SizedBox(
              width: 100,
              child: Text('투룸/빌라+'),
            ),
            SizedBox(
              width: 100,
              child: Text('원룸'),
            ),
            SizedBox(
              width: 100,
              child: Text('오피스텔'),
            ),
          ],
        ),
      ],
    );
  }
}
