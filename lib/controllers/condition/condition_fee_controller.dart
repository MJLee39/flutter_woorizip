import 'package:flutter/material.dart';
import 'package:testapp/widgets/bottom_navigation_widget.dart';
import 'package:testapp/screens/zip_detail_screen.dart';
import 'package:get/get.dart';
import 'package:testapp/controllers/zip_find_controller.dart';

class ConditionFeeController extends GetxController {
  String? selectedFee; // 현재 선택된 월세 유형을 저장하는 변수

  // 선택된 월세 유형을 변경하고, 버튼의 선택 상태를 토글하는 메서드
  void toggleSelection(String feeType) {
    if (selectedFee == feeType) {
      selectedFee = null; // 이미 선택된 상태일 경우, 선택 해제
    } else {
      selectedFee = feeType; // 새로운 유형을 선택
    }
  }

  // 모든 월세 유형의 선택 상태를 해제하는 메서드
  void clearSelection() {
    selectedFee = null;
  }
}
