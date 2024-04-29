import 'package:flutter/material.dart';
import 'package:testapp/controllers/zip_registration_controller.dart';
import 'package:get/get.dart';

class DirectionZipButtonsWidget extends StatefulWidget {
  const DirectionZipButtonsWidget({Key? key});

  @override
  _DirectionZipButtonsWidgetState createState() =>
      _DirectionZipButtonsWidgetState();
}

class _DirectionZipButtonsWidgetState
    extends State<DirectionZipButtonsWidget> {
  final ZipRegistration controller = Get.find<ZipRegistration>();

  final List<String> directions = [
    '북동',
    '북',
    '북서',
    '동',
    '서',
    '남동',
    '남',
    '남서'
  ];

  late List<bool> _selections;

  @override
  void initState() {
    super.initState();
    _selections = List.filled(directions.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ToggleButtons(
        isSelected: _selections,
        onPressed: (int index) {
          setState(() {
            for (int i = 0; i < _selections.length; i++) {
              _selections[i] = i == index;
            }
            controller.direction = directions[index];
          });
        },
        selectedColor: Colors.white,
        fillColor: Colors.indigo,
        children: directions.map((direction) => Text(direction)).toList(),
      ),
    );
  }
}