import 'package:flutter/material.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/screens/zip_detail_screen.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/zip_find_controller.dart';

class BuildingTypeController extends GetxController {
  final _selectedBuildingTypes = <String>{}.obs;
  final _buttonColors = <String, Color>{}.obs; // 버튼 색상 상태 관리 변수

  Set<String> get selectedBuildingTypes => _selectedBuildingTypes.value;
  Map<String, Color> get buttonColors => _buttonColors.value; // 게터 추가

  void toggleSelection(String buildingType) {
    if (_selectedBuildingTypes.contains(buildingType)) {
      _selectedBuildingTypes.remove(buildingType);
      _buttonColors[buildingType] = Colors.grey; // 선택 해제 시 버튼 색상 변경
    } else {
      _selectedBuildingTypes.add(buildingType);
      _buttonColors[buildingType] = Colors.blue; // 선택 시 버튼 색상 변경
    }
  }
}