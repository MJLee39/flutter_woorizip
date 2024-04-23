import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/set_details_controller.dart';
import 'package:testapp/widgets/client/dropdown_fields_widget.dart';

class JusoGuDropdownWidget extends StatefulWidget {
  const JusoGuDropdownWidget({super.key});

  @override
  State<JusoGuDropdownWidget> createState() => _JusoGuDropdownWidgetState();
}

class _JusoGuDropdownWidgetState extends State<JusoGuDropdownWidget> {
  final SetDetailsController controller = Get.find<SetDetailsController>();

  @override
  Widget build(BuildContext context) {
    String initialValue = '강남구';

    controller.gu.value = initialValue;

    return SizedBox(
        height: 50, // 원하는 높이를 지정합니다.
        child: DropdownFieldsWidget(
          options: const [
            '강남구',
            '강동구',
            '강북구',
            '강서구',
            '관악구',
            '광진구',
            '구로구',
            '금천구',
            '노원구',
            '도봉구',
            '동대문구',
            '동작구',
            '마포구',
            '서대문구',
            '서초구',
            '성동구',
            '성북구',
            '송파구',
            '양천구',
            '영등포구',
            '용산구',
            '은평구',
            '종로구',
            '중구',
            '중랑구'
          ],
          initialValue: initialValue,
          onChanged: (String newValue) {
            controller.gu.value = newValue;
          },
        ));
  }
}
