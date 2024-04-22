import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/set_details_controller.dart';

class SetBuildingtypeButtonsWidget extends StatefulWidget {
  const SetBuildingtypeButtonsWidget({super.key});

  @override
  _SetBuildingtypeButtonsWidgetState createState() =>
      _SetBuildingtypeButtonsWidgetState();
}

class _SetBuildingtypeButtonsWidgetState
    extends State<SetBuildingtypeButtonsWidget> {
  final SetDetailsController controller = Get.find<SetDetailsController>();

  final List<String> buildingTypes = ['아파트', '투룸/빌라+', '원룸', '오피스텔'];

  List<bool> _selections = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ToggleButtons(
          isSelected: _selections,
          onPressed: (int index) {
            setState(() {
              _selections =
                  List.generate(_selections.length, (i) => i == index);
              controller.buildingType.value = buildingTypes[index];
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
