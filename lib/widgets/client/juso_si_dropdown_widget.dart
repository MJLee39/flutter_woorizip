import 'package:flutter/material.dart';
import 'package:testapp/widgets/client/dropdown_fields_widget.dart';

class JusoSiDropdownWidget extends StatefulWidget {
  const JusoSiDropdownWidget({super.key});

  @override
  State<JusoSiDropdownWidget> createState() => _JusoSiDropdownWidgetState();
}

class _JusoSiDropdownWidgetState extends State<JusoSiDropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50, // 원하는 높이를 지정합니다.
        child: DropdownFieldsWidget(
          options: const [
            '광주광역시',
            '대구광역시',
            '대전광역시',
            '부산광역시',
            '서울특별시',
            '울산광역시',
            '인천광역시'
          ],
          initialValue: '서울특별시',
          onChanged: (String newValue) {
            // 드롭다운 선택이 변경되었을 때의 동작을 지정
          },
        ));
  }
}
