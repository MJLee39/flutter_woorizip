import 'package:flutter/material.dart';
import 'package:testapp/widgets/client/dropdown_fields_widget.dart';

class JusoDongDropdownWidget extends StatefulWidget {
  const JusoDongDropdownWidget({super.key});

  @override
  State<JusoDongDropdownWidget> createState() => _JusoDongDropdownWidgetState();
}

class _JusoDongDropdownWidgetState extends State<JusoDongDropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50, // 원하는 높이를 지정합니다.
        child: DropdownFieldsWidget(
          options: const [
            '아현동',
            '공덕동',
            '신공덕동',
            '염리동',
            '도화동',
            '마포동',
            '용강동',
            '토정동',
            '대흥동',
            '노고산동',
            '신수동',
            '현석동',
            '구수동',
            '신정동',
            '창천동',
            '상수동',
            '하주동',
            '당인동',
            '서교동',
            '동교동',
            '합정동',
            '망원동',
            '연남동',
            '성산동',
            '중동',
            '상암동'
          ],
          initialValue: '아현동',
          onChanged: (String newValue) {
            // 버튼 선택 시 동작 지정
          },
        ));
  }
}
