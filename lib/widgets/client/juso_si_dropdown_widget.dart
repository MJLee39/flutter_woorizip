import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/condition_controller.dart';
import 'package:testapp/widgets/client/dropdown_fields_widget.dart';

class JusoSiDropdownWidget extends StatefulWidget {
  const JusoSiDropdownWidget({super.key});

  @override
  State<JusoSiDropdownWidget> createState() => _JusoSiDropdownWidgetState();
}

class _JusoSiDropdownWidgetState extends State<JusoSiDropdownWidget> {
  final ConditionController controller = Get.find<ConditionController>();

  @override
  Widget build(BuildContext context) {
    controller.si = '서울특별시';

    return SizedBox(
      height: 50,
      child: DropdownFieldsWidget(
        options: const [
          '서울특별시',
          '부산광역시',
          '대구광역시',
          '인천광역시',
          '광주특별시',
          '대전광역시',
          '울산광역시',
          '세종시',
          '경기도',
          '강원도',
          '충청북도',
          '충청남도',
          '전라북도',
          '전라남도',
          '경상북도',
          '경상남도',
          '제주도',
        ],
        initialValue: '서울특별시',
        onChanged: (String newValue) {
          controller.si = newValue;
        },
      ),
    );
  }
}
