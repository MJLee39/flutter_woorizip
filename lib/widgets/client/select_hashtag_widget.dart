import 'package:flutter/material.dart';

class SelectHashtagWidget extends StatefulWidget {
  const SelectHashtagWidget({super.key});

  @override
  State<SelectHashtagWidget> createState() => SelectHashtagWidgetState();
}

final buttonLabels = [
  '풀옵션',
  '주차가능',
  '엘리베이터',
  '베란다',
  '보안/안전시설',
  '단기임대',
  '역세권',
  '붙박이 옷장',
  '1종 근린',
  '2종 근린',
  '반려동물 가능',
  '신축',
  '에어컨',
  '냉장고',
  '세탁기',
  '신발장',
  '인덕션',
  'CCTV',
];

class SelectHashtagWidgetState extends State<SelectHashtagWidget> {
  final List<bool> _selections = List.filled(buttonLabels.length, false);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
        itemCount: buttonLabels.length,
        itemBuilder: (context, index) {
          return ElevatedButton(
            onPressed: () {
              setState(() {
                _selections[index] = !_selections[index];
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                _selections[index] ? Colors.blue : Colors.white,
              ),
              foregroundColor: MaterialStateProperty.all(
                _selections[index] ? Colors.white : Colors.black,
              ),
            ),
            child: Text(buttonLabels[index]),
          );
        },
      ),
    );
  }
}
