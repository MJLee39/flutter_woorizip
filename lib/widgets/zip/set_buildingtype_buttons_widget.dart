import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/zip_registration_controller.dart';

class SetBuildingtypeButtonsWidget extends StatefulWidget {
  const SetBuildingtypeButtonsWidget({super.key});

  @override
  _SetBuildingtypeButtonsWidgetState createState() =>
      _SetBuildingtypeButtonsWidgetState();
}

class _SetBuildingtypeButtonsWidgetState
    extends State<SetBuildingtypeButtonsWidget> {
  final ZipRegistration controller = Get.find<ZipRegistration>();

  final List<String> buildingTypes = ['아파트', '투룸', '원룸', '오피스텔'];

  List<bool> _selections = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Column이 최소 크기만큼만 차지하도록 설정
      children: [
        ToggleButtons(
          isSelected: _selections,
          onPressed: (int index) {
            setState(() {
              _selections =
                  List.generate(_selections.length, (i) => i == index);
              controller.buildingType = buildingTypes[index];
            });
          },
          selectedColor: Colors.white,
          fillColor: Colors.indigo,
          children: [
            // Remove SizedBox and let ToggleButtons handle the size
            Text('아파트'),
            Text('투룸/빌라+'),
            Text('원룸'),
            Text('오피스텔'),
          ],
        ),
      ],
    );
  }
}
