import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/condition_controller.dart';
import 'package:testapp/widgets/client/dropdown_fields_widget.dart';

class JusoGuDropdownWidget extends StatefulWidget {
  final Function(String)? onChanged;
  const JusoGuDropdownWidget({super.key, this.onChanged});

  @override
  State<JusoGuDropdownWidget> createState() => _JusoGuDropdownWidgetState();
}

class _JusoGuDropdownWidgetState extends State<JusoGuDropdownWidget> {
  final ConditionController controller = Get.find<ConditionController>();

  @override
  Widget build(BuildContext context) {
    // String si = controller.si;

    String initialValue = '강남구';

    controller.gu = initialValue;

    return SizedBox(
        height: 50,
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
            controller.gu = newValue;
            if (widget.onChanged != null) {
              widget.onChanged!(newValue);
            }
          },
        ));
  }
}
