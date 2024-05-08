import 'package:flutter/material.dart';
import 'package:testapp/controllers/search_condition/building_type_controller.dart';
import 'package:testapp/controllers/search_condition/deposit_type_controller.dart';
import 'package:testapp/controllers/search_condition/fee_type_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:testapp/controllers/zip_find_controller.dart';
import 'package:testapp/utils/api_config.dart';
import 'package:testapp/utils/app_colors.dart';

class SearchTypeSelector extends StatefulWidget {
  final BuildingTypeController buildingTypeController;
  final TextEditingController locationController;
  final DepositController depositController;
  final FeeTypeController feeController;

  SearchTypeSelector({
    required this.buildingTypeController,
    required this.locationController,
    required this.depositController,
    required this.feeController,
  });

  @override
  _SearchTypeSelectorState createState() => _SearchTypeSelectorState();
}

class _SearchTypeSelectorState extends State<SearchTypeSelector> {

  final ZipFindController _controller = Get.put(ZipFindController());

  late TextEditingController locationController;

  @override
  void initState() {
    super.initState();
    // 컨트롤러 초기화
    locationController = widget.locationController;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text('유형: '),
              Expanded(
                child: buildBuildingTypeButton('아파트', context),
              ),
              Expanded(
                child: buildBuildingTypeButton('오피스텔', context),
              ),
              Expanded(
                child: buildBuildingTypeButton('원룸', context),
              ),
              Expanded(
                child: buildBuildingTypeButton('투룸/빌라+', context),
              ),
            ],
          ),
          SizedBox(height: 20),
          // 다른 필터 입력 필드
          TextFormField(
            controller: locationController,
            decoration: InputDecoration(labelText: '위치'),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text('보증금: '),
              Expanded(
                child: depositTypeButton('~500', context),
              ),
              Expanded(
                child: depositTypeButton('~1000', context),
              ),
              Expanded(
                child: depositTypeButton('~2000', context),
              ),
              Expanded(
                child: depositTypeButton('2000~', context),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text('월세: '),
              Expanded(
                child: feeTypeButton('~50', context),
              ),
              Expanded(
                child: feeTypeButton('~75', context),
              ),
              Expanded(
                child: feeTypeButton('~100', context),
              ),
              Expanded(
                child: feeTypeButton('100~', context),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: sendRequest,
            child: Text('검색',
              style: TextStyle(color: Colors.white),),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColors.mainColorTest),
            ),
          ),
        ],
      ),
    );
  }

  void sendRequest() async {
    final selectedLocation = widget.locationController.text;
    final selectedBuildingTypes = widget.buildingTypeController.selectedBuildingTypes.join(',');
    final selectedFeeType = widget.feeController.selectedFeeType;
    final selectedDeposit = widget.depositController.selectedDepositType;

    final url = Uri.parse('${ApiConfig.apiSearchZipUrl}?location=$selectedLocation&buildingType=$selectedBuildingTypes&fee=$selectedFeeType&deposit=$selectedDeposit');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // 성공적인 응답 처리
      Iterable<Map<String, dynamic>> responseData = (jsonDecode(utf8.decode(response.bodyBytes))['Zips'] as List<dynamic>)
          .map((dynamic item) => item as Map<String, dynamic>);
      _controller.updateData(responseData.toList()); // 데이터 업데이트
    } else {
      // 요청 실패 처리
      print('Failed to load data: ${response.statusCode}');
    }
  }


  Widget buildBuildingTypeButton(String buttonText, BuildContext context) {
    final isSelected =
    widget.buildingTypeController.selectedBuildingTypes.contains(buttonText);
    final buttonColor = isSelected ? AppColors.mainColor : Colors.grey;

    return ElevatedButton(
      onPressed: () {
        widget.buildingTypeController.toggleSelection(buttonText);
        setState(() {
          // setState를 호출하여 UI를 다시 빌드
        });
      },
      child: Text(buttonText,
        style: TextStyle(color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,// Adjusted font size
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
        // ... 기존 스타일 속성 유지
      ),
    );
  }

  Widget depositTypeButton(String buttonText, BuildContext context) {
    final isSelected =
        widget.depositController.selectedDepositType == buttonText; // 해당 버튼이 선택된 상태인지 확인
    final buttonColor =
    isSelected ? AppColors.mainColor : Colors.grey; // 선택된 상태에 따라 버튼 색상

    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (isSelected) {
            widget.depositController.clearSelection(); // 이미 선택된 버튼이면 선택 해제
          } else {
            widget.depositController.clearSelection();
            widget.depositController.toggleSelection(buttonText);
          }
        });
      },
      child: Text(buttonText,
        style: TextStyle(color: Colors.white,
          fontSize: 11,
        ),),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
      ),
    );
  }

  Widget feeTypeButton(String buttonText, BuildContext context) {
    final isSelected =
        widget.feeController.selectedFeeType == buttonText; // 해당 버튼이 선택된 상태인지 확인
    final buttonColor =
    isSelected ? AppColors.mainColor : Colors.grey; // 선택된 상태에 따라 버튼 색상

    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (isSelected) {
            widget.feeController.clearSelection(); // 이미 선택된 버튼이면 선택 해제
          } else {
            widget.feeController.clearSelection();
            widget.feeController.toggleSelection(buttonText);
          }
        });
      },
      child: Text(buttonText,
          style: TextStyle(color: Colors.white,
            fontSize: 14,)),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
        // ... 기존 스타일 속성 유지
      ),
    );
  }
}