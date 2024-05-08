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

  final List<int> _depositValues = [
    50,
    100,
    200,
    300,
    500,
    1000,
    1500,
    2000,
    3000,
    4000,
    5000,
    0,
  ];
  final List<int> _feeValues = [
    5,
    10,
    20,
    25,
    30,
    35,
    40,
    50,
    60,
    70,
    100,
    0,
  ];
  int _selectedDepositIndex = 0;
  int _selectedFeeIndex = 0;

  @override
  void initState() {
    super.initState();
    locationController = widget.locationController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          color: Colors.black54,
          child: GestureDetector(
            onTap: () {},
            child: DraggableScrollableSheet(
              initialChildSize: 0.9,
              minChildSize: 0.9,
              maxChildSize: 0.95,
              builder: (_, controller) {
                return Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: ListView(
                    controller: controller,
                    children: [
                      Text('방 종류',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              child: buildBuildingTypeButton('원룸', context)),
                          SizedBox(width: 10),
                          Expanded(
                              child: buildBuildingTypeButton('투,쓰리룸', context)),
                          SizedBox(width: 10),
                          Expanded(
                              child: buildBuildingTypeButton('오피스텔', context)),
                          SizedBox(width: 10),
                          Expanded(
                              child: buildBuildingTypeButton('아파트', context)),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text('거래유형',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(child: depositTypeButton('월세', context)),
                          SizedBox(width: 10),
                          Expanded(child: depositTypeButton('전세', context)),
                          SizedBox(width: 10),
                          Expanded(child: depositTypeButton('매매', context)),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text('가격', style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Stack(
                        children: [
                          Slider(
                            activeColor: AppColors.mainColorTest,
                            inactiveColor: Colors.grey,
                            value: _selectedDepositIndex.toDouble(),
                            min: 0,
                            max: _depositValues.length - 1,
                            divisions: _depositValues.length - 1,
                            onChanged: (value) {
                              setState(() {
                                _selectedDepositIndex = value.toInt();
                              });
                            },
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment(
                                  (_selectedDepositIndex /
                                              (_depositValues.length - 1)) *
                                          2 -
                                      1,
                                  -1),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '${_depositValues[_selectedDepositIndex]}만원',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${_depositValues[0]}만원'),
                          Text('${_depositValues[3]}만원'),
                          Text('${_depositValues[7]}만원'),
                          Text('${_depositValues[11]}만원'),
                        ],
                      ),
                      SizedBox(height: 20),
                      Stack(
                        children: [
                          Slider(
                            inactiveColor: Colors.grey,
                            activeColor: AppColors.mainColorTest,
                            value: _selectedFeeIndex.toDouble(),
                            min: 0,
                            max: _feeValues.length - 1,
                            divisions: _feeValues.length - 1,
                            onChanged: (value) {
                              setState(() {
                                _selectedFeeIndex = value.toInt();
                              });
                            },
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment(
                                  (_selectedFeeIndex /
                                              (_feeValues.length - 1)) *
                                          2 -
                                      1,
                                  -1),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '${_feeValues[_selectedFeeIndex]}만원',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${_feeValues[0]}만원'),
                          Text('${_feeValues[3]}만원'),
                          Text('${_feeValues[7]}만원'),
                          Text('${_feeValues[11]}만원'),
                        ],
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: sendRequest,
                          child: Text(
                            '적용하기',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(vertical: 15)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            backgroundColor: MaterialStateProperty.all(
                                AppColors.mainColorTest),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void sendRequest() async {
    final selectedLocation = widget.locationController.text;
    final selectedBuildingTypes =
        widget.buildingTypeController.selectedBuildingTypes.join(',');
    final selectedDeposit = _depositValues[_selectedDepositIndex];
    final selectedFee = _feeValues[_selectedFeeIndex];

    final url = Uri.parse(
        '${ApiConfig.apiSearchZipUrl}?location=$selectedLocation&buildingType=$selectedBuildingTypes&fee=$selectedFee&deposit=$selectedDeposit');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      Iterable<Map<String, dynamic>> responseData =
          (jsonDecode(utf8.decode(response.bodyBytes))['Zips'] as List<dynamic>)
              .map((dynamic item) => item as Map<String, dynamic>);
      _controller.updateData(responseData.toList());
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  }

  Widget buildBuildingTypeButton(String buttonText, BuildContext context) {
    final isSelected = widget.buildingTypeController.selectedBuildingTypes
        .contains(buttonText);
    final buttonColor = isSelected ? AppColors.mainColorTest : Colors.grey;

    return ElevatedButton(
      onPressed: () {
        widget.buildingTypeController.toggleSelection(buttonText);
        setState(() {});
      },
      child: Text(
        buttonText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }

  Widget depositTypeButton(String buttonText, BuildContext context) {
    final isSelected =
        widget.depositController.selectedDepositType == buttonText;
    final buttonColor = isSelected ? AppColors.mainColorTest : Colors.grey;

    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (isSelected) {
            widget.depositController.clearSelection();
          } else {
            widget.depositController.clearSelection();
            widget.depositController.toggleSelection(buttonText);
          }
        });
      },
      child: Text(
        buttonText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }

  Widget feeTypeButton(String buttonText, BuildContext context) {
    final isSelected = widget.feeController.selectedFeeType == buttonText;
    final buttonColor = isSelected ? AppColors.mainColor : Colors.grey;

    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (isSelected) {
            widget.feeController.clearSelection();
          } else {
            widget.feeController.clearSelection();
            widget.feeController.toggleSelection(buttonText);
          }
        });
      },
      child: Text(
        buttonText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}
