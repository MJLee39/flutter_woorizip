import 'package:flutter/material.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/screens/zip_detail_screen.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/zip_find_controller.dart';

class ConditionMoveInDateController extends GetxController {
  final _selectedMoveInDate = <String>{}.obs;
  final _buttonColors = <String, Color>{}.obs; // 버튼 색상 상태 관리 변수

  Set<String> get selectedBuildingTypes => _selectedMoveInDate.value;
  Map<String, Color> get buttonColors => _buttonColors.value; // 게터 추가

  void toggleSelection(String buildingType) {
    if (_selectedMoveInDate.contains(buildingType)) {
      _selectedMoveInDate.remove(buildingType);
      _buttonColors[buildingType] = Colors.grey; // 선택 해제 시 버튼 색상 변경
    } else {
      _selectedMoveInDate.add(buildingType);
      _buttonColors[buildingType] = Colors.blue; // 선택 시 버튼 색상 변경
    }
  }
}
