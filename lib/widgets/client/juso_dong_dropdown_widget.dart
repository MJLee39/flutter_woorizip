import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/condition_controller.dart';
import 'package:testapp/widgets/client/dropdown_fields_widget.dart';

class JusoDongDropdownWidget extends StatefulWidget {
  final Function(String)? onChanged;
  const JusoDongDropdownWidget({super.key, this.onChanged});

  @override
  State<JusoDongDropdownWidget> createState() => _JusoDongDropdownWidgetState();
}

class _JusoDongDropdownWidgetState extends State<JusoDongDropdownWidget> {

  final ConditionController controller = Get.find<ConditionController>();

  @override
  Widget build(BuildContext context) {
    String initialValue = '아현동';

    controller.dong = initialValue;

    return SizedBox(
        height: 50,
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
          initialValue: initialValue,
          onChanged: (String newValue) {
            controller.dong = newValue;
            if (widget.onChanged != null) {
              widget.onChanged!(newValue);
            }
          },
        ));
  }
}
