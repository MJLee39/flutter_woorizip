import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/condition/condition_controller.dart';

class SetBuildingtypeButtonsWidget extends StatefulWidget {
  const SetBuildingtypeButtonsWidget({super.key});

  @override
  _SetBuildingtypeButtonsWidgetState createState() =>
      _SetBuildingtypeButtonsWidgetState();
}

class _SetBuildingtypeButtonsWidgetState
    extends State<SetBuildingtypeButtonsWidget> {
  final ConditionController controller = Get.find<ConditionController>();

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
              _selections[index] = !_selections[index];

              List<String> selectedBuildingTypes = [];
              for (int i = 0; i < 4; i++) {
                if (_selections[i]) {
                  selectedBuildingTypes.add(buildingTypes[i]);
                }
              }

              controller.buildingType = selectedBuildingTypes.join(', ');
            });
          },
          selectedColor: Colors.white,
          fillColor: Colors.indigo,
          children: buildingTypes.map((type) {
            return SizedBox(
              width: 80,
              child: Center(
                child: Text(type),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
