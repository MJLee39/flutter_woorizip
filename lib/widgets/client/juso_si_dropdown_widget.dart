import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/set_details_controller.dart';
import 'package:testapp/widgets/client/dropdown_fields_widget.dart';

class JusoSiDropdownWidget extends StatefulWidget {
  const JusoSiDropdownWidget({super.key});

  @override
  State<JusoSiDropdownWidget> createState() => _JusoSiDropdownWidgetState();
}

class _JusoSiDropdownWidgetState extends State<JusoSiDropdownWidget> {
  final SetDetailsController controller = Get.find<SetDetailsController>();

  @override
  Widget build(BuildContext context) {
    String initialValue = '서울특별시';

    controller.si.value = initialValue;

    return SizedBox(
      height: 50,
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
        initialValue: initialValue,
        onChanged: (String newValue) {
          controller.si.value = newValue;
        },
      ),
    );
  }
}
