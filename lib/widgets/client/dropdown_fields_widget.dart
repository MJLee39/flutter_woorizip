import 'package:flutter/material.dart';

class DropdownFieldsWidget extends StatefulWidget {
  final List<String> options; // 드롭다운 옵션 목록
  final String initialValue; // 초기 선택된 값
  final ValueChanged<String> onChanged; // 값이 변경될 때 호출되는 콜백 함수

  const DropdownFieldsWidget({
    super.key,
    required this.options,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  _DropdownFieldsWidgetState createState() => _DropdownFieldsWidgetState();
}

class _DropdownFieldsWidgetState extends State<DropdownFieldsWidget> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue; // 초기값 설정
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedValue,
      items: widget.options.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue!;
        });
        widget.onChanged(newValue!);
      },
    );
  }
}
